/*
 * Kestrel 2 Baseline Emulator
 * Release 1p1
 *
 * Copyright (c) 2006 Samuel A. Falvo II
 * All Rights Reserved
 */

#include <stdio.h>
#include <lib65816/cpu.h>
#include "io.h"
#include <winsock2.h>
#include <windows.h>
#include <ws2tcpip.h>
#include <conio.h>


#define DEFAULT_BUFLEN 1
#define DEFAULT_PORT "816"
#define DEFAULT_PORT_NR 816

SOCKET ClientSocket = INVALID_SOCKET;

int write_socket(char c) {
	int iSendResult;

	//printf("%c", c);
	// Echo the buffer back to the sender
	iSendResult = send(ClientSocket, &c, 1, 0);

	if (iSendResult == SOCKET_ERROR)
	{
		printf("send failed with error: %d\n", WSAGetLastError());
		closesocket(ClientSocket);
		WSACleanup();
		exit(0);
	}
	//printf("Bytes sent: %d\n", iSendResult);

	return 1;
}



char read_socket() {
	int iResult;
    char recvbuf[DEFAULT_BUFLEN];
    int recvbuflen = DEFAULT_BUFLEN;

	iResult = recv(ClientSocket, recvbuf, recvbuflen, 0);
	printf("recv: %d bytes: %c\n", iResult, *recvbuf);

	if (iResult <= 0) {
		printf("recv failed with error: %d\n", WSAGetLastError());
		closesocket(ClientSocket);
		WSACleanup();
		exit(0);
	}
	
	//printf("%c", recvbuf[0]);
	return (char) (recvbuf[0]);
}


int initialize_socket() {
    WSADATA wsaData;
    int iResult;

    SOCKET ListenSocket = INVALID_SOCKET;
 
    struct addrinfo *result = NULL;
    struct addrinfo hints;

	char* cmd="C:\\github\\my65816\\build\\ttermpro.cmd";
	printf("%s\n", cmd);

	system (cmd);

    printf("sizeof int: %d\n", sizeof(int));

    printf("Initialising Winsock...\n");
    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0)
    {
        printf("WSAStartup failed with error: %d\n", iResult);
        return 1;
    }

    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags = AI_PASSIVE;

    // Resolve the server address and port
    iResult = getaddrinfo(NULL, DEFAULT_PORT, &hints, &result);
    if (iResult != 0)
    {
        printf("getaddrinfo failed with error: %d\n", iResult);
        WSACleanup();
        return 1;
    }

    // Create a SOCKET for the server to listen for client connections.
    ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET)
    {
        printf("socket failed with error: %ld\n", WSAGetLastError());
        freeaddrinfo(result);
        WSACleanup();
        return 1;
    }

    // Setup the TCP listening socket
    iResult = bind(ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR)
    {
        printf("bind failed with error: %d\n", WSAGetLastError());
        freeaddrinfo(result);
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    freeaddrinfo(result);

    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR)
    {
        printf("listen failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // Accept a client socket
	printf("waiting for connection on port %d\n", DEFAULT_PORT_NR);
    ClientSocket = accept(ListenSocket, NULL, NULL);
    if (ClientSocket == INVALID_SOCKET)
    {
        printf("accept failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // No longer need server socket
    closesocket(ListenSocket);	

	printf("socket accepted\n");
}


int io_initialize(void) {
	int success = 1;


	initialize_socket();

	if (!success)
		fprintf( stderr, "IO failed to initialize\n");

	return success;
}

void io_expunge(void) {
	//mgia_expunge();
}

byte io_read(word32 address, word32 timestamp) {
	//word32 adr_palette = address & IOMASK_PALETTE;

	if ((address & 0xFF00) == 0xD900) {
		return (byte) read_socket();
	}

	/*
	 if( ( address & IOMASK_MGIA ) == IOBASE_MGIA )
	 return mgia_read( address, timestamp );

	 if( ( address & IOMASK_IRQC ) == IOBASE_IRQC )
	 return irqc_read( address, timestamp );
	 */
	/*
	if ((address & IOMASK_MOUSE) == IOBASE_MOUSE)
		return mouse_read(address, timestamp);
	else if ((address & IOMASK_KIMO) == IOBASE_KIMO)
		return kimo_read(address, timestamp);
	else if ((address & IOMASK_DISPLAY) == IOBASE_DISPLAY)
		return display_read(address, timestamp);
	else if ((address & IOMASK_TIMER) == IOBASE_TIMER)
		return timer_read(address, timestamp);
	else if (adr_palette == IOBASE_PALETTE0 || adr_palette == IOBASE_PALETTE1)
		return display_read_palette(address, timestamp);
	*/	
	/*
	 if( ( address & IOMASK_TIMERS ) == IOBASE_TIMERS )
	 return timers_read( address, timestamp );

	 if( ( address & IOMASK_SERBUS ) == IOBASE_SERBUS )
	 return serbus_read( address, timestamp );
	 */
	return 0x00;
}

void io_write(word32 address, byte b, word32 timestamp) {
	
	//word32 adr_palette = address & IOMASK_PALETTE;

	if ((address & 0xFF00) == 0xD800) {
		write_socket((char) b);
	}

	/*
	if ((address & IOMASK_MOUSE) == IOBASE_MOUSE)
		mouse_write(address, b, timestamp);
	else if ((address & IOMASK_KIMO) == IOBASE_KIMO)
		kimo_write(address, b, timestamp);
	else if ((address & IOMASK_DISPLAY) == IOBASE_DISPLAY)
		display_write(address, b, timestamp);
	else if ((address & IOMASK_TIMER) == IOBASE_TIMER)
		timer_write(address, b, timestamp);
	else if (adr_palette == IOBASE_PALETTE0 || adr_palette == IOBASE_PALETTE1) {
		display_write_palette(address, b, timestamp);
	}
	*/
	/*
	 else if( ( address & IOMASK_TIMERS ) == IOBASE_TIMERS )
	 timers_write( address, b, timestamp );

	 else if( ( address & IOMASK_SERBUS ) == IOBASE_SERBUS )
	 serbus_write( address, b, timestamp );
	 */
}

/*
 static void
 fps_update( void )
 {
 extern word32 frames;
 static word32 reference = 0;
 word32 now;

 if( reference == 0 )
 reference = SDL_GetTicks();

 now = SDL_GetTicks();
 if( ( now - reference ) > 1000 )
 {
 fprintf( stderr, "\r  FPS: %ld   ", frames );
 fprintf( stderr, "CPU Performance: %ld%%   ", (10*frames)/6);

 frames = 0; reference = now;
 }
 }
 */

//void EMUL_hardwareUpdate( word32 timestamp )
//{
//    fps_update();
//    mgia_update( timestamp );
//    kimo_update( timestamp );
//    irqc_update( timestamp );   /* update this last, to make sure we get all IRQs */
//}
