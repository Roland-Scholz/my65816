/*
 * lib65816/debugger.c Release 1p1
 * Copyright (C) 2006 by Samuel A. Falvo II
 * See LICENSE for more details.
 *
 * 2007 Jan 5 saf2
 * Complete rewrite as the old "debugger" (really a tracer) was just rife
 * with bugs and utterly lacking in suitable features.
 */

#include <lib65816/config.h>
#include <stdlib.h>

#ifdef DEBUG

#include <lib65816/cpu.h>
#include <stdio.h>

#include "cpumicro.h"

/* 65816 debugger module */

static int debug_cnt = 0;

char *mnemonics[256] = {
"BRK", "ORA", "COP", "ORA", "TSB", "ORA", "ASL", "ORA",
"PHP", "ORA", "ASL", "PHD", "TSB", "ORA", "ASL", "ORA",
"BPL", "ORA", "ORA", "ORA", "TRB", "ORA", "ASL", "ORA",
"CLC", "ORA", "INC", "TCS", "TRB", "ORA", "ASL", "ORA",
"JSR", "AND", "JSL", "AND", "BIT", "AND", "ROL", "AND",
"PLP", "AND", "ROL", "PLD", "BIT", "AND", "ROL", "AND",
"BMI", "AND", "AND", "AND", "BIT", "AND", "ROL", "AND",
"SEC", "AND", "DEC", "TSC", "BIT", "AND", "ROL", "AND",
"RTI", "EOR", "WDM", "EOR", "MVP", "EOR", "LSR", "EOR",
"PHA", "EOR", "LSR", "PHK", "JMP", "EOR", "LSR", "EOR",
"BVC", "EOR", "EOR", "EOR", "MVN", "EOR", "LSR", "EOR",
"CLI", "EOR", "PHY", "TCD", "JMP", "EOR", "LSR", "EOR",
"RTS", "ADC", "PER", "ADC", "STZ", "ADC", "ROR", "ADC",
"PLA", "ADC", "ROR", "RTL", "JMP", "ADC", "ROR", "ADC",
"BVS", "ADC", "ADC", "ADC", "STZ", "ADC", "ROR", "ADC",
"SEI", "ADC", "PLY", "TDC", "JMP", "ADC", "ROR", "ADC",
"BRA", "STA", "BRL", "STA", "STY", "STA", "STX", "STA",
"DEY", "BIT", "TXA", "PHB", "STY", "STA", "STX", "STA",
"BCC", "STA", "STA", "STA", "STY", "STA", "STX", "STA",
"TYA", "STA", "TXS", "TXY", "STZ", "STA", "STZ", "STA",
"LDY", "LDA", "LDX", "LDA", "LDY", "LDA", "LDX", "LDA",
"TAY", "LDA", "TAX", "PLB", "LDY", "LDA", "LDX", "LDA",
"BCS", "LDA", "LDA", "LDA", "LDY", "LDA", "LDX", "LDA",
"CLV", "LDA", "TSX", "TYX", "LDY", "LDA", "LDX", "LDA",
"CPY", "CMP", "REP", "CMP", "CPY", "CMP", "DEC", "CMP",
"INY", "CMP", "DEX", "WAI", "CPY", "CMP", "DEC", "CMP",
"BNE", "CMP", "CMP", "CMP", "PEI", "CMP", "DEC", "CMP",
"CLD", "CMP", "PHX", "STP", "JML", "CMP", "DEC", "CMP",
"CPX", "SBC", "SEP", "SBC", "CPX", "SBC", "INC", "SBC",
"INX", "SBC", "NOP", "XBA", "CPX", "SBC", "INC", "SBC",
"BEQ", "SBC", "SBC", "SBC", "PEA", "SBC", "INC", "SBC",
"SED", "SBC", "PLX", "XCE", "JSR", "SBC", "INC", "SBC"
};

enum modes {
    IMM8,
    IMM,
    IMMX,
    ACC,
    PCR,
    PCRL,
    IMPL,
    DP,
    DPX,
    DPY,
    DPI,
    DPIX,
    DPIY,
    DPIL,
    DPILY,
    ABS,
    ABSX,
    ABSY,
    ABSL,
    ABSLX,
    STK,
    STKIY,
    ABSI,
    ABSIX,
    BLK
};

int addrmodes[256] = {
    IMM8, DPIX, IMM8, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, ACC, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   DP, DPX, DPX, DPILY,
        IMPL, ABSY, ACC, IMPL,   ABS, ABSX, ABSX, ABSLX,
    ABS, DPIX, ABSL, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, ACC, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   DPX, DPX, DPX, DPILY,
        IMPL, ABSY, ACC, IMPL,   ABSX, ABSX, ABSX, ABSLX,

    IMPL, DPIX, IMM8, STK,   BLK, DP, DP, DPIL,
        IMPL, IMM, ACC, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   BLK, DPX, DPX, DPILY,
        IMPL, ABSY, IMPL, IMPL,   ABSL, ABSX, ABSX, ABSX,
    IMPL, DPIX, IMPL, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, ACC, IMPL,   ABSI, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   DPX, DPX, DPX, DPILY,
        IMPL, ABSY, IMPL, IMPL,   ABSIX, ABSX, ABSX, ABSLX,


    PCR, DPIX, PCRL, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, IMPL, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   DPX, DPX, DPX, DPILY,
        IMPL, ABSY, IMPL, IMPL,   ABS, ABSX, ABSX, ABSLX,
    IMMX, DPIX, IMMX, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, IMPL, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   DPX, DPX, DPY, DPILY,
        IMPL, ABSY, IMPL, IMPL,   ABSX, ABSX, ABSY, ABSLX,

    IMMX, DPIX, IMM8, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, IMPL, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   DPI, DPX, DPX, DPILY,
        IMPL, ABSY, IMPL, IMPL,   ABSI, ABSX, ABSX, ABSLX,
    IMMX, DPIX, IMM8, STK,   DP, DP, DP, DPIL,
        IMPL, IMM, IMPL, IMPL,   ABS, ABS, ABS, ABSL,
    PCR, DPIY, DPI, STKIY,   ABS, DPX, DPX, DPILY,
        IMPL, ABSY, IMPL, IMPL,   ABSIX, ABSX, ABSX, ABSLX
};

void CPU_debug(void) {
	int	opcode;
	//int	mode;
	//int	operand;
    //int ea;
    //char operands[40];

    //if (debug_cnt++ > 150) exit (0);

	opcode = M_READ(PC.A);
	//mode = addrmodes[opcode];
	printf(" A=%04X X=%04X Y=%04X S=%04X D=%04X B=%02X P=%02X ", (int) A.W, (int) X.W,
									   (int) Y.W, (int) S.W,
									   (int) D.W, (int) DB,
									   (int) P);
	printf("%02X/%04X %02X ",(int) PC.B.PB,(int) PC.W.PC,opcode);
	/*
	printf("Cyc=%012d A=%04X X=%04X Y=%04X S=%04X D=%04X B=%02X P=%02X E=%1d  ", cpu_cycle_sum, (int) A.W, (int) X.W,
									   (int) Y.W, (int) S.W,
									   (int) D.W, (int) DB,
									   (int) P, (int) E);
	printf("%02X/%04X  %s ",(int) PC.B.PB,(int) PC.W.PC,mnemonics[opcode]);
	*/
	/* switch (mode) {
        case IMM8:
            sprintf( operands, "#$%02X", M_READ(PC.A+1) );
            break;

        case IMM:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            if( F_getM ) sprintf( operands, "#$%02X", (operand & 0xFF));
            else         sprintf( operands, "#$%04X", operand );
            break;

        case IMMX:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            if( F_getX ) sprintf( operands, "#$%02X", (operand & 0xFF));
            else         sprintf( operands, "#$%04X", operand );
            break;

        case ACC:
            sprintf( operands, "A" );
            break;

        case PCR:
            operand = M_READ(PC.A+1);
            sprintf( operands, "$%02X ($%02X%04X)", operand, PC.B.PB, PC.W.PC + operand + 2);
            break;

        case PCRL:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            sprintf( operands, "$%02X ($%02X%04X)", operand, PC.B.PB, PC.W.PC + operand + 3);
            break;

        case IMPL:
            sprintf( operands, "" );
            break;

        case DP:
            operand = M_READ(PC.A+1);
            ea = D.W + operand;
            sprintf( operands, "$%02X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPX:
            operand = M_READ(PC.A+1);
            if( F_getX ) ea = D.W + operand + X.B.L;
            else         ea = D.W + operand + X.W;
            sprintf( operands, "$%02X,X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPY:
            operand = M_READ(PC.A+1);
            if( F_getX ) ea = D.W + operand + Y.B.L;
            else         ea = D.W + operand + Y.W;
            sprintf( operands, "$%02X,Y (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPI:
            operand = M_READ(PC.A+1);
            ea = D.W + operand;
            ea = M_READ(ea) | (M_READ(ea+1)<<8) | (DB<<16);
            sprintf( operands, "($%02X) (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPIX:
            operand = M_READ(PC.A+1);
            if( F_getX ) ea = D.W + operand + X.B.L;
            else         ea = D.W + operand + X.W;
            ea = M_READ(ea) | (M_READ(ea+1)<<8) | (DB<<16);
            sprintf( operands, "($%02X,X) (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPIY:
            operand = M_READ(PC.A+1);
            ea = D.W + operand;
            if( F_getX ) ea = M_READ(ea) | (M_READ(ea+1)<<8) | ((DB<<16) + Y.B.L);
            else         ea = M_READ(ea) | (M_READ(ea+1)<<8) | ((DB<<16) + Y.W);
            sprintf( operands, "($%02X),Y (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPIL:
            operand = M_READ(PC.A+1);
            ea = D.W + operand;
            ea = M_READ(ea) | (M_READ(ea+1)<<8) | (M_READ(ea+2)<<16);
            sprintf( operands, "[$%02X] (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case DPILY:
            operand = M_READ(PC.A+1);
            ea = D.W + operand;
            if( F_getX ) ea = M_READ(ea) | (M_READ(ea+1)<<8) | ((M_READ(ea+2)<<16) + Y.B.L);
            else         ea = M_READ(ea) | (M_READ(ea+1)<<8) | ((M_READ(ea+2)<<16) + Y.W);
            sprintf( operands, "[$%02X],Y (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABS:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            ea = operand + (DB<<16);
            sprintf( operands, "$%04X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABSX:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            if( F_getX ) ea = operand + (DB<<16) + X.B.L;
            else         ea = operand + (DB<<16) + X.W;
            sprintf( operands, "$%04X,X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABSY:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            if( F_getX ) ea = operand + (DB<<16) + Y.B.L;
            else         ea = operand + (DB<<16) + Y.W;
            sprintf( operands, "$%04X,Y (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABSL:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8) | (M_READ(PC.A+3)<<16);
            ea = operand;
            sprintf( operands, "$%06X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABSLX:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8) | (M_READ(PC.A+3)<<16);
            if( F_getX ) ea = operand + X.B.L;
            else         ea = operand + X.W;
            sprintf( operands, "$%06X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABSI:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            ea = M_READ(operand) + (M_READ(operand+1)<<8) + (DB<<16);
            sprintf( operands, "$%04X (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case ABSIX:
            operand = M_READ(PC.A+1) | (M_READ(PC.A+2)<<8);
            ea = operand | (PC.B.PB << 16);
            ea = M_READ(ea) + (M_READ(ea+1)<<8) + (PC.B.PB<<16);
            sprintf( operands, "($%04X,X) (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case STK:
            operand = M_READ(PC.A+1);
            ea = operand + S.W;
            sprintf( operands, "$%02X,S (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case STKIY:
            operand = M_READ(PC.A+1);
            ea = operand + S.W;
            if( F_getX ) ea = M_READ(ea) + (M_READ(ea+1)<<8) + (DB<<16) + Y.B.L;
            else         ea = M_READ(ea) + (M_READ(ea+1)<<8) + (DB<<16) + Y.W;

            sprintf( operands, "$%02X,S (@%06X %02X %02X %02X ...)",
                operand, ea, M_READ(ea), M_READ(ea+1), M_READ(ea+2) );
            break;

        case BLK:
            sprintf( operands, "$%02X, $%02X", M_READ(PC.A+2), M_READ(PC.A+1) );
            break;
	} */
//    printf( "%s\n", operands );
    printf( "\n");
	fflush(stdout);
}

#endif
