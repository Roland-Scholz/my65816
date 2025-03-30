;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
~~tokens:
	dl	L1+0
	dw	$3,$2
	db	$FF,$10,$FF,$10,$0,$0
	dl	L1+4
	dw	$3,$2
	db	$FF,$11,$FF,$11,$0,$0
	dl	L1+8
	dw	$5,$2
	db	$FF,$12,$FF,$12,$0,$0
	dl	L1+14
	dw	$3,$1
	db	$0,$80,$0,$80,$0,$0
	dl	L1+18
	dw	$4,$4
	db	$FF,$13,$FF,$13,$0,$0
	dl	L1+23
	dw	$5,$5
	db	$FF,$14,$FF,$14,$0,$0
	dl	L1+29
	dw	$3,$2
	db	$FF,$15,$FF,$15,$0,$0
	dl	L1+33
	dw	$3,$3
	db	$FF,$16,$FF,$16,$0,$0
	dl	L1+37
	dw	$3,$2
	db	$FF,$17,$FF,$17,$0,$0
	dl	L1+41
	dw	$5,$2
	db	$0,$8D,$0,$8D,$0,$0
	dl	L1+47
	dw	$4,$4
	db	$FF,$18,$FF,$18,$0,$0
	dl	L1+52
	dw	$4,$1
	db	$FF,$19,$FF,$19,$1,$0
	dl	L1+57
	dw	$4,$2
	db	$0,$8E,$0,$8E,$1,$0
	dl	L1+62
	dw	$4,$2
	db	$0,$8F,$0,$8F,$0,$0
	dl	L1+67
	dw	$4,$3
	db	$0,$90,$0,$90,$0,$0
	dl	L1+72
	dw	$5,$2
	db	$0,$92,$0,$92,$0,$0
	dl	L1+78
	dw	$4,$4
	db	$FF,$1A,$FF,$1A,$0,$0
	dl	L1+83
	dw	$6,$2
	db	$0,$93,$0,$93,$0,$0
	dl	L1+90
	dw	$5,$2
	db	$0,$95,$0,$95,$1,$0
	dl	L1+96
	dw	$5,$3
	db	$0,$96,$0,$96,$1,$0
	dl	L1+102
	dw	$3,$3
	db	$0,$94,$0,$94,$1,$0
	dl	L1+106
	dw	$3,$3
	db	$0,$97,$0,$97,$1,$0
	dl	L1+110
	dw	$5,$1
	db	$0,$98,$0,$98,$0,$0
	dl	L1+116
	dw	$6,$1
	db	$0,$98,$0,$98,$0,$0
	dl	L1+123
	dw	$3,$3
	db	$FF,$1B,$FF,$1B,$0,$0
	dl	L1+127
	dw	$5,$3
	db	$FF,$1C,$FF,$1C,$1,$0
	dl	L1+133
	dw	$4,$1
	db	$0,$99,$0,$99,$0,$0
	dl	L1+138
	dw	$3,$3
	db	$0,$9A,$0,$9A,$0,$0
	dl	L1+142
	dw	$3,$2
	db	$FF,$1D,$FF,$1D,$0,$0
	dl	L1+146
	dw	$3,$3
	db	$0,$9B,$0,$9B,$0,$0
	dl	L1+150
	dw	$3,$2
	db	$0,$82,$0,$82,$0,$0
	dl	L1+154
	dw	$6,$5
	db	$0,$9D,$0,$9D,$0,$0
	dl	L1+161
	dw	$4,$2
	db	$0,$9C,$0,$9C,$0,$0
	dl	L1+166
	dw	$7,$3
	db	$0,$9E,$0,$9E,$0,$0
	dl	L1+174
	dw	$4,$2
	db	$0,$9F,$0,$9F,$0,$1
	dl	L1+179
	dw	$7,$4
	db	$0,$A4,$0,$A4,$1,$0
	dl	L1+187
	dw	$5,$4
	db	$0,$A5,$0,$A5,$1,$0
	dl	L1+193
	dw	$7,$1
	db	$0,$A6,$0,$A6,$1,$0
	dl	L1+201
	dw	$8,$4
	db	$0,$A7,$0,$A7,$1,$0
	dl	L1+210
	dw	$3,$3
	db	$0,$A3,$0,$A3,$1,$0
	dl	L1+214
	dw	$8,$3
	db	$0,$A8,$0,$A8,$0,$0
	dl	L1+223
	dw	$3,$3
	db	$FF,$1E,$FF,$1E,$1,$0
	dl	L1+227
	dw	$3,$3
	db	$0,$83,$0,$83,$0,$0
	dl	L1+231
	dw	$3,$3
	db	$FF,$1F,$FF,$1F,$1,$0
	dl	L1+235
	dw	$5,$3
	db	$0,$A9,$0,$A9,$0,$0
	dl	L1+241
	dw	$3,$3
	db	$FF,$20,$FF,$20,$1,$0
	dl	L1+245
	dw	$4,$2
	db	$FF,$21,$FF,$21,$0,$0
	dl	L1+250
	dw	$3,$3
	db	$FF,$22,$FF,$22,$0,$0
	dl	L1+254
	dw	$3,$3
	db	$FF,$2,$FF,$2,$1,$0
	dl	L1+258
	dw	$5,$2
	db	$0,$AA,$0,$AA,$1,$0
	dl	L1+264
	dw	$9,$4
	db	$FF,$3,$FF,$3,$0,$0
	dl	L1+274
	dw	$4,$2
	db	$0,$AB,$0,$AB,$0,$0
	dl	L1+279
	dw	$2,$2
	db	$0,$AD,$0,$AD,$0,$0
	dl	L1+282
	dw	$3,$1
	db	$0,$AE,$0,$AE,$0,$0
	dl	L1+286
	dw	$4,$2
	db	$0,$AF,$0,$AF,$0,$0
	dl	L1+291
	dw	$4,$2
	db	$FF,$24,$FF,$24,$0,$0
	dl	L1+296
	dw	$3,$3
	db	$FF,$23,$FF,$23,$0,$0
	dl	L1+300
	dw	$5,$3
	db	$0,$B0,$0,$B0,$0,$1
	dl	L1+306
	dw	$4,$1
	db	$0,$B1,$0,$B1,$0,$1
	dl	L1+311
	dw	$5,$1
	db	$FF,$1,$FF,$1,$1,$0
	dl	L1+317
	dw	$2,$2
	db	$0,$B2,$0,$B2,$0,$0
	dl	L1+320
	dw	$6,$3
	db	$FF,$26,$FF,$26,$0,$0
	dl	L1+327
	dw	$5,$5
	db	$FF,$25,$FF,$25,$0,$0
	dl	L1+333
	dw	$5,$1
	db	$0,$B5,$0,$B5,$0,$0
	dl	L1+339
	dw	$6,$3
	db	$FF,$27,$FF,$27,$0,$0
	dl	L1+346
	dw	$3,$3
	db	$FF,$28,$FF,$28,$0,$0
	dl	L1+350
	dw	$6,$2
	db	$FF,$4,$FF,$4,$0,$0
	dl	L1+357
	dw	$3,$3
	db	$FF,$29,$FF,$29,$0,$0
	dl	L1+361
	dw	$3,$3
	db	$0,$B6,$0,$B6,$0,$0
	dl	L1+365
	dw	$7,$3
	db	$0,$B7,$0,$B7,$0,$0
	dl	L1+373
	dw	$4,$3
	db	$0,$B8,$0,$B8,$0,$0
	dl	L1+378
	dw	$2,$2
	db	$FF,$2B,$FF,$2B,$0,$0
	dl	L1+381
	dw	$5,$3
	db	$0,$B9,$0,$B9,$0,$0
	dl	L1+387
	dw	$3,$3
	db	$FF,$2C,$FF,$2C,$0,$0
	dl	L1+391
	dw	$5,$3
	db	$FF,$5,$FF,$5,$1,$0
	dl	L1+397
	dw	$5,$1
	db	$FF,$6,$FF,$6,$0,$0
	dl	L1+403
	dw	$4,$2
	db	$0,$BA,$0,$BA,$0,$0
	dl	L1+408
	dw	$3,$3
	db	$0,$89,$0,$89,$0,$0
	dl	L1+412
	dw	$5,$3
	db	$0,$BB,$0,$BB,$0,$0
	dl	L1+418
	dw	$6,$6
	db	$0,$BD,$0,$BD,$0,$0
	dl	L1+425
	dw	$4,$3
	db	$0,$BC,$0,$BC,$0,$0
	dl	L1+430
	dw	$4,$1
	db	$0,$BE,$0,$BE,$0,$0
	dl	L1+435
	dw	$3,$3
	db	$0,$BF,$0,$BF,$0,$0
	dl	L1+439
	dw	$3,$3
	db	$0,$C1,$0,$C1,$0,$0
	dl	L1+443
	dw	$2,$2
	db	$0,$C0,$0,$C0,$0,$0
	dl	L1+446
	dw	$2,$2
	db	$0,$C2,$0,$C2,$0,$0
	dl	L1+449
	dw	$6,$2
	db	$FF,$2D,$FF,$2D,$0,$0
	dl	L1+456
	dw	$7,$5
	db	$FF,$2E,$FF,$2E,$0,$0
	dl	L1+464
	dw	$6,$5
	db	$FF,$2F,$FF,$2F,$0,$0
	dl	L1+471
	dw	$6,$2
	db	$0,$C3,$0,$C3,$0,$0
	dl	L1+478
	dw	$2,$2
	db	$0,$8B,$0,$8B,$0,$0
	dl	L1+481
	dw	$5,$2
	db	$0,$C4,$0,$C4,$0,$0
	dl	L1+487
	dw	$9,$2
	db	$0,$C5,$0,$C5,$0,$0
	dl	L1+497
	dw	$7,$2
	db	$0,$C7,$0,$C7,$0,$0
	dl	L1+505
	dw	$4,$2
	db	$FF,$7,$FF,$7,$1,$0
	dl	L1+510
	dw	$2,$2
	db	$FF,$30,$FF,$30,$1,$0
	dl	L1+513
	dw	$4,$2
	db	$0,$C8,$0,$C8,$0,$0
	dl	L1+518
	dw	$7,$7
	db	$0,$CB,$0,$CB,$0,$0
	dl	L1+526
	dw	$7,$7
	db	$0,$CA,$0,$CA,$0,$0
	dl	L1+534
	dw	$6,$2
	db	$FF,$31,$FF,$31,$0,$0
	dl	L1+541
	dw	$5,$5
	db	$0,$C9,$0,$C9,$0,$0
	dl	L1+547
	dw	$3,$3
	db	$FF,$32,$FF,$32,$1,$0
	dl	L1+551
	dw	$5,$1
	db	$0,$CC,$0,$CC,$0,$0
	dl	L1+557
	dw	$4,$4
	db	$0,$CD,$0,$CD,$0,$0
	dl	L1+562
	dw	$3,$3
	db	$FF,$8,$FF,$8,$1,$0
	dl	L1+566
	dw	$4,$1
	db	$0,$CE,$0,$CE,$1,$0
	dl	L1+571
	dw	$3,$2
	db	$FF,$33,$FF,$33,$0,$0
	dl	L1+575
	dw	$4,$3
	db	$0,$CF,$0,$CF,$0,$0
	dl	L1+580
	dw	$9,$3
	db	$0,$D0,$0,$D0,$0,$0
	dl	L1+590
	dw	$3,$3
	db	$0,$D1,$0,$D1,$0,$0
	dl	L1+594
	dw	$6,$3
	db	$0,$D2,$0,$D2,$0,$0
	dl	L1+601
	dw	$7,$7
	db	$FF,$34,$FF,$34,$0,$0
	dl	L1+609
	dw	$6,$4
	db	$0,$D3,$0,$D3,$1,$0
	dl	L1+616
	dw	$7,$3
	db	$0,$D4,$0,$D4,$0,$1
	dl	L1+624
	dw	$6,$1
	db	$0,$D5,$0,$D5,$1,$0
	dl	L1+631
	dw	$7,$2
	db	$FF,$9,$FF,$9,$0,$0
	dl	L1+639
	dw	$3,$2
	db	$FF,$36,$FF,$36,$1,$0
	dl	L1+643
	dw	$3,$2
	db	$0,$D6,$0,$D6,$1,$0
	dl	L1+647
	dw	$3,$2
	db	$FF,$37,$FF,$37,$0,$0
	dl	L1+651
	dw	$3,$2
	db	$FF,$38,$FF,$38,$0,$0
	dl	L1+655
	dw	$5,$2
	db	$0,$D7,$0,$D7,$0,$0
	dl	L1+661
	dw	$3,$3
	db	$FE,$1,$FE,$1,$0,$0
	dl	L1+665
	dw	$3,$3
	db	$FF,$39,$FF,$39,$0,$0
	dl	L1+669
	dw	$4,$1
	db	$0,$D9,$0,$D9,$0,$0
	dl	L1+674
	dw	$6,$4
	db	$0,$DA,$0,$DA,$0,$0
	dl	L1+681
	dw	$4,$3
	db	$0,$DB,$0,$DB,$1,$0
	dl	L1+686
	dw	$4,$3
	db	$FF,$3A,$FF,$3A,$0,$0
	dl	L1+691
	dw	$8,$4
	db	$FF,$3B,$FF,$3B,$0,$0
	dl	L1+700
	dw	$3,$2
	db	$FF,$3C,$FF,$3C,$0,$0
	dl	L1+704
	dw	$4,$2
	db	$0,$DC,$0,$DC,$0,$0
	dl	L1+709
	dw	$3,$2
	db	$0,$DD,$0,$DD,$0,$0
	dl	L1+713
	dw	$4,$4
	db	$FE,$2,$FE,$2,$0,$0
	dl	L1+718
	dw	$3,$1
	db	$FF,$3D,$FF,$3D,$0,$0
	dl	L1+722
	dw	$5,$2
	db	$0,$DE,$FF,$3E,$0,$0
	dl	L1+728
	dw	$4,$2
	db	$0,$DF,$0,$DF,$0,$1
	dl	L1+733
	dw	$5,$5
	db	$FF,$B,$FF,$B,$1,$0
	dl	L1+739
	dw	$4,$2
	db	$FF,$A,$FF,$A,$1,$0
	dl	L1+744
	dw	$4,$3
	db	$0,$E0,$0,$E0,$0,$0
	dl	L1+749
	dw	$2,$3
	db	$0,$E1,$0,$E1,$0,$0
	dl	L1+752
	dw	$5,$2
	db	$0,$E2,$0,$E2,$0,$0
	dl	L1+758
	dw	$4,$3
	db	$0,$E3,$0,$E3,$1,$0
	dl	L1+763
	dw	$5,$1
	db	$0,$E4,$0,$E4,$0,$0
	dl	L1+769
	dw	$3,$2
	db	$FF,$3F,$FF,$3F,$0,$0
	dl	L1+773
	dw	$3,$2
	db	$FF,$40,$FF,$40,$0,$0
	dl	L1+777
	dw	$3,$1
	db	$0,$E5,$0,$E5,$0,$0
	dl	L1+781
	dw	$7,$2
	db	$FF,$41,$FF,$41,$0,$0
	dl	L1+789
	dw	$6,$2
	db	$0,$E7,$0,$E7,$0,$0
	dl	L1+796
	dw	$5,$5
	db	$0,$E6,$0,$E6,$0,$0
	dl	L1+802
	dw	$4,$2
	db	$FF,$42,$FF,$42,$1,$0
	dl	L1+807
	dw	$4,$2
	db	$0,$E8,$0,$E8,$1,$0
	dl	L1+812
	dw	$4,$3
	db	$0,$E9,$0,$E9,$0,$0
	dl	L1+817
	dw	$5,$1
	db	$0,$EB,$0,$EB,$0,$0
	dl	L1+823
	dw	$5,$2
	db	$0,$ED,$0,$ED,$0,$0
	dl	L1+829
	dw	$7,$2
	db	$FF,$43,$FF,$43,$0,$0
	dl	L1+837
	dw	$6,$2
	db	$FC,$1,$FC,$1,$0,$0
	dl	L1+844
	dw	$4,$2
	db	$FC,$2,$FC,$2,$0,$0
	dl	L1+849
	dw	$6,$2
	db	$FC,$3,$FC,$3,$0,$0
	dl	L1+856
	dw	$6,$3
	db	$FC,$4,$FC,$4,$0,$0
	dl	L1+863
	dw	$5,$5
	db	$FC,$6,$FC,$6,$0,$0
	dl	L1+869
	dw	$4,$2
	db	$FC,$5,$FC,$5,$0,$0
	dl	L1+874
	dw	$4,$2
	db	$FC,$7,$FC,$7,$1,$0
	dl	L1+879
	dw	$7,$5
	db	$FC,$8,$FC,$8,$0,$0
	dl	L1+887
	dw	$5,$5
	db	$FC,$A,$FC,$A,$0,$0
	dl	L1+893
	dw	$6,$6
	db	$FC,$B,$FC,$B,$0,$0
	dl	L1+900
	dw	$5,$5
	db	$FC,$C,$FC,$C,$0,$0
	dl	L1+906
	dw	$5,$5
	db	$FC,$D,$FF,$2A,$0,$0
	dl	L1+912
	dw	$5,$5
	db	$FC,$E,$FC,$E,$0,$0
	dl	L1+918
	dw	$4,$1
	db	$FC,$9,$FC,$9,$0,$0
	dl	L1+923
	dw	$4,$2
	db	$FC,$F,$FC,$F,$0,$0
	dl	L1+928
	dw	$4,$3
	db	$FC,$10,$FC,$10,$1,$0
	dl	L1+933
	dw	$3,$3
	db	$FC,$11,$FC,$11,$1,$0
	dl	L1+937
	dw	$3,$1
	db	$FC,$12,$FC,$12,$1,$0
	dl	L1+941
	dw	$4,$1
	db	$0,$CE,$0,$CE,$1,$0
	dl	L1+946
	dw	$8,$3
	db	$FC,$13,$FC,$13,$0,$0
	dl	L1+955
	dw	$3,$2
	db	$0,$D6,$0,$D6,$1,$0
	dl	L1+959
	dw	$5,$5
	db	$FC,$15,$FC,$15,$0,$0
	dl	L1+965
	dw	$4,$2
	db	$FC,$14,$FC,$14,$0,$0
	dl	L1+970
	dw	$8,$3
	db	$FC,$16,$FC,$16,$0,$0
	dl	L1+979
	dw	$9,$9
	db	$FC,$18,$FC,$18,$0,$0
	dl	L1+989
	dw	$8,$5
	db	$FC,$17,$FC,$17,$0,$0
	dl	L1+998
	dw	$5,$2
	db	$FC,$1A,$FC,$1A,$1,$0
	dl	L1+1004
	dw	$4,$4
	db	$FC,$19,$FC,$19,$1,$0
	dl	L1+1009
	dw	$1,$1
	db	$0,$0,$0,$0,$0,$0
	ends
	data
L1:
	db	$41,$42,$53,$00,$41,$43,$53,$00,$41,$44,$56,$41,$4C,$00,$41
	db	$4E,$44,$00,$41,$52,$47,$43,$00,$41,$52,$47,$56,$24,$00,$41
	db	$53,$43,$00,$41,$53,$4E,$00,$41,$54,$4E,$00,$42,$45,$41,$54
	db	$53,$00,$42,$45,$41,$54,$00,$42,$47,$45,$54,$00,$42,$50,$55
	db	$54,$00,$43,$41,$4C,$4C,$00,$43,$41,$53,$45,$00,$43,$48,$41
	db	$49,$4E,$00,$43,$48,$52,$24,$00,$43,$49,$52,$43,$4C,$45,$00
	db	$43,$4C,$45,$41,$52,$00,$43,$4C,$4F,$53,$45,$00,$43,$4C,$47
	db	$00,$43,$4C,$53,$00,$43,$4F,$4C,$4F,$52,$00,$43,$4F,$4C,$4F
	db	$55,$52,$00,$43,$4F,$53,$00,$43,$4F,$55,$4E,$54,$00,$44,$41
	db	$54,$41,$00,$44,$45,$46,$00,$44,$45,$47,$00,$44,$49,$4D,$00
	db	$44,$49,$56,$00,$44,$52,$41,$57,$42,$59,$00,$44,$52,$41,$57
	db	$00,$45,$4C,$4C,$49,$50,$53,$45,$00,$45,$4C,$53,$45,$00,$45
	db	$4E,$44,$43,$41,$53,$45,$00,$45,$4E,$44,$49,$46,$00,$45,$4E
	db	$44,$50,$52,$4F,$43,$00,$45,$4E,$44,$57,$48,$49,$4C,$45,$00
	db	$45,$4E,$44,$00,$45,$4E,$56,$45,$4C,$4F,$50,$45,$00,$45,$4F
	db	$46,$00,$45,$4F,$52,$00,$45,$52,$4C,$00,$45,$52,$52,$4F,$52
	db	$00,$45,$52,$52,$00,$45,$56,$41,$4C,$00,$45,$58,$50,$00,$45
	db	$58,$54,$00,$46,$41,$4C,$53,$45,$00,$46,$49,$4C,$45,$50,$41
	db	$54,$48,$24,$00,$46,$49,$4C,$4C,$00,$46,$4E,$00,$46,$4F,$52
	db	$00,$47,$43,$4F,$4C,$00,$47,$45,$54,$24,$00,$47,$45,$54,$00
	db	$47,$4F,$53,$55,$42,$00,$47,$4F,$54,$4F,$00,$48,$49,$4D,$45
	db	$4D,$00,$49,$46,$00,$49,$4E,$4B,$45,$59,$24,$00,$49,$4E,$4B
	db	$45,$59,$00,$49,$4E,$50,$55,$54,$00,$49,$4E,$53,$54,$52,$28
	db	$00,$49,$4E,$54,$00,$4C,$45,$46,$54,$24,$28,$00,$4C,$45,$4E
	db	$00,$4C,$45,$54,$00,$4C,$49,$42,$52,$41,$52,$59,$00,$4C,$49
	db	$4E,$45,$00,$4C,$4E,$00,$4C,$4F,$43,$41,$4C,$00,$4C,$4F,$47
	db	$00,$4C,$4F,$4D,$45,$4D,$00,$4D,$49,$44,$24,$28,$00,$4D,$4F
	db	$44,$45,$00,$4D,$4F,$44,$00,$4D,$4F,$55,$53,$45,$00,$4D,$4F
	db	$56,$45,$42,$59,$00,$4D,$4F,$56,$45,$00,$4E,$45,$58,$54,$00
	db	$4E,$4F,$54,$00,$4F,$46,$46,$00,$4F,$46,$00,$4F,$4E,$00,$4F
	db	$50,$45,$4E,$49,$4E,$00,$4F,$50,$45,$4E,$4F,$55,$54,$00,$4F
	db	$50,$45,$4E,$55,$50,$00,$4F,$52,$49,$47,$49,$4E,$00,$4F,$52
	db	$00,$4F,$53,$43,$4C,$49,$00,$4F,$54,$48,$45,$52,$57,$49,$53
	db	$45,$00,$4F,$56,$45,$52,$4C,$41,$59,$00,$50,$41,$47,$45,$00
	db	$50,$49,$00,$50,$4C,$4F,$54,$00,$50,$4F,$49,$4E,$54,$54,$4F
	db	$00,$50,$4F,$49,$4E,$54,$42,$59,$00,$50,$4F,$49,$4E,$54,$28
	db	$00,$50,$4F,$49,$4E,$54,$00,$50,$4F,$53,$00,$50,$52,$49,$4E
	db	$54,$00,$50,$52,$4F,$43,$00,$50,$54,$52,$00,$51,$55,$49,$54
	db	$00,$52,$41,$44,$00,$52,$45,$41,$44,$00,$52,$45,$43,$54,$41
	db	$4E,$47,$4C,$45,$00,$52,$45,$4D,$00,$52,$45,$50,$45,$41,$54
	db	$00,$52,$45,$50,$4F,$52,$54,$24,$00,$52,$45,$50,$4F,$52,$54
	db	$00,$52,$45,$53,$54,$4F,$52,$45,$00,$52,$45,$54,$55,$52,$4E
	db	$00,$52,$49,$47,$48,$54,$24,$28,$00,$52,$4E,$44,$00,$52,$55
	db	$4E,$00,$53,$47,$4E,$00,$53,$49,$4E,$00,$53,$4F,$55,$4E,$44
	db	$00,$53,$50,$43,$00,$53,$51,$52,$00,$53,$54,$45,$50,$00,$53
	db	$54,$45,$52,$45,$4F,$00,$53,$54,$4F,$50,$00,$53,$54,$52,$24
	db	$00,$53,$54,$52,$49,$4E,$47,$24,$28,$00,$53,$55,$4D,$00,$53
	db	$57,$41,$50,$00,$53,$59,$53,$00,$54,$41,$42,$28,$00,$54,$41
	db	$4E,$00,$54,$45,$4D,$50,$4F,$00,$54,$48,$45,$4E,$00,$54,$49
	db	$4D,$45,$24,$00,$54,$49,$4D,$45,$00,$54,$49,$4E,$54,$00,$54
	db	$4F,$00,$54,$52,$41,$43,$45,$00,$54,$52,$55,$45,$00,$55,$4E
	db	$54,$49,$4C,$00,$55,$53,$52,$00,$56,$41,$4C,$00,$56,$44,$55
	db	$00,$56,$45,$52,$49,$46,$59,$28,$00,$56,$4F,$49,$43,$45,$53
	db	$00,$56,$4F,$49,$43,$45,$00,$56,$50,$4F,$53,$00,$57,$41,$49
	db	$54,$00,$57,$48,$45,$4E,$00,$57,$48,$49,$4C,$45,$00,$57,$49
	db	$44,$54,$48,$00,$58,$4C,$41,$54,$45,$24,$28,$00,$41,$50,$50
	db	$45,$4E,$44,$00,$41,$55,$54,$4F,$00,$43,$52,$55,$4E,$43,$48
	db	$00,$44,$45,$4C,$45,$54,$45,$00,$45,$44,$49,$54,$4F,$00,$45
	db	$44,$49,$54,$00,$48,$45,$4C,$50,$00,$49,$4E,$53,$54,$41,$4C
	db	$4C,$00,$4C,$49,$53,$54,$42,$00,$4C,$49,$53,$54,$49,$46,$00
	db	$4C,$49,$53,$54,$4C,$00,$4C,$49,$53,$54,$4F,$00,$4C,$49,$53
	db	$54,$57,$00,$4C,$49,$53,$54,$00,$4C,$4F,$41,$44,$00,$4C,$56
	db	$41,$52,$00,$4E,$45,$57,$00,$4F,$4C,$44,$00,$51,$55,$49,$54
	db	$00,$52,$45,$4E,$55,$4D,$42,$45,$52,$00,$52,$55,$4E,$00,$53
	db	$41,$56,$45,$4F,$00,$53,$41,$56,$45,$00,$54,$45,$58,$54,$4C
	db	$4F,$41,$44,$00,$54,$45,$58,$54,$53,$41,$56,$45,$4F,$00,$54
	db	$45,$58,$54,$53,$41,$56,$45,$00,$54,$57,$49,$4E,$4F,$00,$54
	db	$57,$49,$4E,$00,$5A,$5A,$00
	ends
	data
~~start_letter:
	dw	$0,$9,$D,$1A,$21,$31,$36,$3B,$3C,$FF
	dw	$FF,$42,$4B,$51,$53,$5E,$69,$6A,$76,$83
	dw	$8D,$8F,$95,$99,$FF,$FF
	ends
	data
~~command_start:
	dw	$9A,$FF,$9C,$9D,$9E,$FF,$FF,$A0,$A1,$FF
	dw	$FF,$A2,$FF,$AA,$AB,$FF,$AC,$AD,$AF,$B1
	dw	$FF,$FF,$FF,$FF,$FF,$FF
	ends
	code
	xdef	~~isempty
	func
~~isempty:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L3
	tcs
	phd
	tcd
line_0	set	4
	stz	<R0
	ldy	#$6
	lda	[<L3+line_0],Y
	and	#$ff
	beq	L6
	brl	L5
L6:
	inc	<R0
L5:
	lda	<R0
	and	#$ff
L7:
	tay
	lda	<L3+2
	sta	<L3+2+4
	lda	<L3+1
	sta	<L3+1+4
	pld
	tsc
	clc
	adc	#L3+4
	tcs
	tya
	rtl
L3	equ	4
L4	equ	5
	ends
	efunc
	code
	xdef	~~save_lineno
	func
~~save_lineno:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
where_0	set	4
number_0	set	8
	sep	#$20
	longa	off
	lda	<L8+number_0
	sta	[<L8+where_0]
	rep	#$20
	longa	on
	lda	<L8+number_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$1
	sta	[<L8+where_0],Y
	rep	#$20
	longa	on
L10:
	lda	<L8+2
	sta	<L8+2+6
	lda	<L8+1
	sta	<L8+1+6
	pld
	tsc
	clc
	adc	#L8+6
	tcs
	rtl
L8	equ	0
L9	equ	1
	ends
	efunc
	code
	func
~~store_lineno:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
number_0	set	4
	clc
	lda	#$2
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L13
	eor	#$8000
L13:
	bmi	L14
	brl	L10001
L14:
	pea	#<$a
	pea	#4
	jsl	~~error
L10001:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L11+number_0
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~next
	ina
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	lda	<L11+number_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	inc	|~~next
	inc	|~~next
L15:
	lda	<L11+2
	sta	<L11+2+2
	lda	<L11+1
	sta	<L11+1+2
	pld
	tsc
	clc
	adc	#L11+2
	tcs
	rtl
L11	equ	8
L12	equ	9
	ends
	efunc
	code
	func
~~store_linelen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
length_0	set	4
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L16+length_0
	ldy	#$2
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	lda	<L16+length_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$3
	sta	[<R0],Y
	rep	#$20
	longa	on
L18:
	lda	<L16+2
	sta	<L16+2+2
	lda	<L16+1
	sta	<L16+1+2
	pld
	tsc
	clc
	adc	#L16+2
	tcs
	rtl
L16	equ	4
L17	equ	5
	ends
	efunc
	code
	func
~~store_exec:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L19
	tcs
	phd
	tcd
offset_0	set	4
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L19+offset_0
	ldy	#$4
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	lda	<L19+offset_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$5
	sta	[<R0],Y
	rep	#$20
	longa	on
L21:
	lda	<L19+2
	sta	<L19+2+2
	lda	<L19+1
	sta	<L19+1+2
	pld
	tsc
	clc
	adc	#L19+2
	tcs
	rtl
L19	equ	4
L20	equ	5
	ends
	efunc
	code
	xdef	~~get_linelen
	func
~~get_linelen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
	tcs
	phd
	tcd
p_0	set	4
	ldy	#$2
	lda	[<L22+p_0],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L22+p_0],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
L24:
	tay
	lda	<L22+2
	sta	<L22+2+4
	lda	<L22+1
	sta	<L22+1+4
	pld
	tsc
	clc
	adc	#L22+4
	tcs
	tya
	rtl
L22	equ	12
L23	equ	13
	ends
	efunc
	code
	xdef	~~get_lineno
	func
~~get_lineno:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L25
	tcs
	phd
	tcd
p_0	set	4
	lda	[<L25+p_0]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L25+p_0],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
L27:
	tay
	lda	<L25+2
	sta	<L25+2+4
	lda	<L25+1
	sta	<L25+1+4
	pld
	tsc
	clc
	adc	#L25+4
	tcs
	tya
	rtl
L25	equ	12
L26	equ	13
	ends
	efunc
	code
	xdef	~~get_exec
	func
~~get_exec:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
p_0	set	4
	ldy	#$4
	lda	[<L28+p_0],Y
	and	#$ff
	sta	<R0
	ldy	#$5
	lda	[<L28+p_0],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
L30:
	tay
	lda	<L28+2
	sta	<L28+2+4
	lda	<L28+1
	sta	<L28+1+4
	pld
	tsc
	clc
	adc	#L28+4
	tcs
	tya
	rtl
L28	equ	12
L29	equ	13
	ends
	efunc
	code
	func
~~store:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L31
	tcs
	phd
	tcd
token_0	set	4
	lda	|~~next
	ina
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L33
	eor	#$8000
L33:
	bmi	L34
	brl	L10002
L34:
	pea	#<$a
	pea	#4
	jsl	~~error
L10002:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L31+token_0
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	inc	|~~next
L35:
	lda	<L31+2
	sta	<L31+2+2
	lda	<L31+1
	sta	<L31+1+2
	pld
	tsc
	clc
	adc	#L31+2
	tcs
	rtl
L31	equ	4
L32	equ	5
	ends
	efunc
	code
	func
~~store_size:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L36
	tcs
	phd
	tcd
size_0	set	4
	clc
	lda	#$2
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L38
	eor	#$8000
L38:
	bmi	L39
	brl	L10003
L39:
	pea	#<$a
	pea	#4
	jsl	~~error
L10003:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L36+size_0
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~next
	ina
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	lda	<L36+size_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	inc	|~~next
	inc	|~~next
L40:
	lda	<L36+2
	sta	<L36+2+2
	lda	<L36+1
	sta	<L36+1+2
	pld
	tsc
	clc
	adc	#L36+2
	tcs
	rtl
L36	equ	8
L37	equ	9
	ends
	efunc
	code
	func
~~store_longoffset:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L41
	tcs
	phd
	tcd
value_0	set	4
n_1	set	0
	clc
	lda	#$4
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L43
	eor	#$8000
L43:
	bmi	L44
	brl	L10004
L44:
	pea	#<$a
	pea	#4
	jsl	~~error
L10004:
	lda	#$1
	sta	<L42+n_1
L10007:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L41+value_0
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L41+value_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sta	<L41+value_0
	inc	|~~next
L10005:
	inc	<L42+n_1
	lda	<L42+n_1
	bmi	L45
	dea
	dea
	dea
	dea
	dea
	bpl	L46
L45:
	brl	L10007
L46:
L10006:
L47:
	lda	<L41+2
	sta	<L41+2+2
	lda	<L41+1
	sta	<L41+1+2
	pld
	tsc
	clc
	adc	#L41+2
	tcs
	rtl
L41	equ	6
L42	equ	5
	ends
	efunc
	code
	func
~~store_shortoffset:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L48
	tcs
	phd
	tcd
value_0	set	4
	clc
	lda	#$2
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L50
	eor	#$8000
L50:
	bmi	L51
	brl	L10008
L51:
	pea	#<$a
	pea	#4
	jsl	~~error
L10008:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L48+value_0
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~next
	ina
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	lda	<L48+value_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	inc	|~~next
	inc	|~~next
L52:
	lda	<L48+2
	sta	<L48+2+2
	lda	<L48+1
	sta	<L48+1+2
	pld
	tsc
	clc
	adc	#L48+2
	tcs
	rtl
L48	equ	8
L49	equ	9
	ends
	efunc
	code
	func
~~store_intconst:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L53
	tcs
	phd
	tcd
value_0	set	4
n_1	set	0
	clc
	lda	#$4
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L55
	eor	#$8000
L55:
	bmi	L56
	brl	L10009
L56:
	pea	#<$a
	pea	#4
	jsl	~~error
L10009:
	lda	#$1
	sta	<L54+n_1
L10012:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L53+value_0
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L53+value_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sta	<L53+value_0
	inc	|~~next
L10010:
	inc	<L54+n_1
	lda	<L54+n_1
	bmi	L57
	dea
	dea
	dea
	dea
	dea
	bpl	L58
L57:
	brl	L10012
L58:
L10011:
L59:
	lda	<L53+2
	sta	<L53+2+2
	lda	<L53+1
	sta	<L53+1+2
	pld
	tsc
	clc
	adc	#L53+2
	tcs
	rtl
L53	equ	6
L54	equ	5
	ends
	efunc
	code
	func
~~store_fpvalue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L60
	tcs
	phd
	tcd
fpvalue_0	set	4
temp_1	set	0
n_1	set	4
	clc
	lda	#$4
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L62
	eor	#$8000
L62:
	bmi	L63
	brl	L10013
L63:
	pea	#<$a
	pea	#4
	jsl	~~error
L10013:
	pea	#^$4
	pea	#<$4
	pea	#0
	clc
	tdc
	adc	#<L60+fpvalue_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L61+temp_1
	pha
	jsl	~~memcpy
	stz	<L61+n_1
	brl	L10017
L10016:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldx	<L61+n_1
	lda	<L61+temp_1,X
	ldy	|~~next
	sta	[<R0],Y
	rep	#$20
	longa	on
	inc	|~~next
L10014:
	inc	<L61+n_1
L10017:
	lda	<L61+n_1
	cmp	#<$4
	bcs	L64
	brl	L10016
L64:
L10015:
L65:
	lda	<L60+2
	sta	<L60+2+4
	lda	<L60+1
	sta	<L60+1+4
	pld
	tsc
	clc
	adc	#L60+4
	tcs
	rtl
L60	equ	10
L61	equ	5
	ends
	efunc
	code
	func
~~convert_lineno:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L66
	tcs
	phd
	tcd
line_1	set	0
	stz	<L67+line_1
L10018:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L68
	brl	L10019
L68:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<R0]
	rep	#$20
	longa	on
	bcs	L69
	brl	L10019
L69:
	ldy	#$0
	lda	<L67+line_1
	bpl	L70
	dey
L70:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L71
	eor	#$8000
L71:
	bmi	L72
	brl	L10019
L72:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	lda	<L67+line_1
	asl	A
	asl	A
	adc	<L67+line_1
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L67+line_1
	inc	|~~lp
	bne	L73
	inc	|~~lp+2
L73:
	brl	L10018
L10019:
	ldy	#$0
	lda	<L67+line_1
	bpl	L74
	dey
L74:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L75
	eor	#$8000
L75:
	bpl	L76
	brl	L10020
L76:
	lda	#$b
	sta	|~~lasterror
	pea	#<$85
	pea	#4
	jsl	~~error
	stz	<L67+line_1
L10021:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L77
	brl	L10022
L77:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<R0]
	rep	#$20
	longa	on
	bcs	L78
	brl	L10022
L78:
	inc	|~~lp
	bne	L79
	inc	|~~lp+2
L79:
	brl	L10021
L10022:
L10020:
	lda	<L67+line_1
L80:
	tay
	pld
	tsc
	clc
	adc	#L66
	tcs
	tya
	rtl
L66	equ	14
L67	equ	13
	ends
	efunc
	code
	func
~~copy_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L81
	tcs
	phd
	tcd
lp_0	set	4
L10023:
	lda	[<L81+lp_0]
	and	#$ff
	bne	L83
	brl	L10024
L83:
	lda	[<L81+lp_0]
	pha
	jsl	~~store
	inc	<L81+lp_0
	bne	L84
	inc	<L81+lp_0+2
L84:
	brl	L10023
L10024:
	ldx	<L81+lp_0+2
	lda	<L81+lp_0
L85:
	tay
	lda	<L81+2
	sta	<L81+2+4
	lda	<L81+1
	sta	<L81+1+4
	pld
	tsc
	clc
	adc	#L81+4
	tcs
	tya
	rtl
L81	equ	0
L82	equ	1
	ends
	efunc
	code
	func
~~nextis:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L86
	tcs
	phd
	tcd
string_0	set	4
cp_1	set	0
	lda	|~~lp+2
	pha
	lda	|~~lp
	pha
	jsl	~~skip_blanks
	sta	<L87+cp_1
	stx	<L87+cp_1+2
	stz	<R0
	lda	[<L87+cp_1]
	and	#$ff
	bne	L89
	brl	L88
L89:
	pei	<L86+string_0+2
	pei	<L86+string_0
	jsl	~~strlen
	sta	<R1
	stx	<R1+2
	phx
	pha
	pei	<L86+string_0+2
	pei	<L86+string_0
	pei	<L87+cp_1+2
	pei	<L87+cp_1
	jsl	~~strncmp
	tax
	beq	L90
	brl	L88
L90:
	inc	<R0
L88:
	lda	<R0
	and	#$ff
L91:
	tay
	lda	<L86+2
	sta	<L86+2+4
	lda	<L86+1
	sta	<L86+1+4
	pld
	tsc
	clc
	adc	#L86+4
	tcs
	tya
	rtl
L86	equ	12
L87	equ	9
	ends
	efunc
	code
	func
~~kwsearch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L92
	tcs
	phd
	tcd
n_1	set	0
count_1	set	2
kwlength_1	set	4
first_1	set	6
cp_1	set	7
nomatch_1	set	11
abbreviated_1	set	12
keyword_1	set	13
	lda	|~~lp
	sta	<L93+cp_1
	lda	|~~lp+2
	sta	<L93+cp_1+2
	stz	<L93+n_1
	brl	L10028
L10027:
	sep	#$20
	longa	off
	lda	[<L93+cp_1]
	ldx	<L93+n_1
	sta	<L93+keyword_1,X
	rep	#$20
	longa	on
	inc	<L93+cp_1
	bne	L94
	inc	<L93+cp_1+2
L94:
L10025:
	inc	<L93+n_1
L10028:
	sec
	lda	<L93+n_1
	sbc	#<$a
	bvs	L96
	eor	#$8000
L96:
	bpl	L97
	brl	L95
L97:
	lda	[<L93+cp_1]
	and	#$ff
	pha
	jsl	~~isalpha
	tax
	beq	L98
	brl	L10027
L98:
	sep	#$20
	longa	off
	lda	[<L93+cp_1]
	cmp	#<$24
	rep	#$20
	longa	on
	bne	L99
	brl	L10027
L99:
	sep	#$20
	longa	off
	lda	[<L93+cp_1]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L100
	brl	L10027
L100:
L95:
L10026:
	stz	<R0
	sec
	lda	<L93+n_1
	sbc	#<$a
	bvs	L102
	eor	#$8000
L102:
	bpl	L103
	brl	L101
L103:
	sep	#$20
	longa	off
	lda	[<L93+cp_1]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L104
	brl	L101
L104:
	inc	<R0
L101:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L93+abbreviated_1
	rep	#$20
	longa	on
	lda	<L93+abbreviated_1
	and	#$ff
	beq	L105
	brl	L10029
L105:
	lda	<L93+n_1
	cmp	#<$1
	beq	L106
	brl	L10029
L106:
	lda	#$ff
L107:
	tay
	pld
	tsc
	clc
	adc	#L92
	tcs
	tya
	rtl
L10029:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L93+n_1
	sta	<L93+keyword_1,X
	rep	#$20
	longa	on
	lda	<L93+n_1
	sta	<L93+kwlength_1
	sep	#$20
	longa	off
	lda	<L93+keyword_1
	sta	<L93+first_1
	rep	#$20
	longa	on
	lda	<L93+first_1
	and	#$ff
	pha
	jsl	~~islower
	tax
	bne	L108
	brl	L10030
L108:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L93+nomatch_1
	rep	#$20
	longa	on
	brl	L10031
L10030:
	lda	<L93+first_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~start_letter-130,X
	sta	<L93+n_1
	lda	<L93+n_1
	cmp	#<$ff
	beq	L109
	brl	L10032
L109:
	lda	#$ff
	brl	L107
L10032:
L10035:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~tokens+4,X
	sta	<L93+count_1
	lda	<L93+abbreviated_1
	and	#$ff
	bne	L110
	brl	L10036
L110:
	sec
	lda	<L93+kwlength_1
	sbc	<L93+count_1
	bvs	L111
	eor	#$8000
L111:
	bpl	L112
	brl	L10036
L112:
	lda	<L93+kwlength_1
	sta	<L93+count_1
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sec
	lda	<L93+kwlength_1
	ldx	<R0
	sbc	|~~tokens+6,X
	bvs	L113
	eor	#$8000
L113:
	bpl	L114
	brl	L10037
L114:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~tokens+6,X
	sta	<L93+count_1
L10037:
L10036:
	ldy	#$0
	lda	<L93+count_1
	bpl	L115
	dey
L115:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	#<~~tokens
	adc	<R1
	sta	<R2
	ldy	#$2
	lda	(<R2),Y
	pha
	lda	(<R2)
	pha
	pea	#0
	clc
	tdc
	adc	#<L93+keyword_1
	pha
	jsl	~~strncmp
	tax
	bne	L116
	brl	L10034
L116:
	inc	<L93+n_1
L10033:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#<~~tokens
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<R0
	ldy	#$2
	lda	(<R1),Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	<L93+first_1
	rep	#$20
	longa	on
	bne	L117
	brl	L10035
L117:
L10034:
	stz	<R0
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	#<~~tokens
	adc	<R1
	sta	<R2
	lda	(<R2)
	sta	<R1
	ldy	#$2
	lda	(<R2),Y
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	<L93+first_1
	rep	#$20
	longa	on
	bne	L119
	brl	L118
L119:
	inc	<R0
L118:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L93+nomatch_1
	rep	#$20
	longa	on
	lda	<L93+nomatch_1
	and	#$ff
	beq	L120
	brl	L10038
L120:
	lda	<L93+abbreviated_1
	and	#$ff
	bne	L121
	brl	L10038
L121:
	stz	<R0
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	sec
	lda	<L93+kwlength_1
	ldx	<R1
	sbc	|~~tokens+4,X
	bvs	L123
	eor	#$8000
L123:
	bpl	L124
	brl	L122
L124:
	inc	<R0
L122:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L93+abbreviated_1
	rep	#$20
	longa	on
L10038:
L10031:
	lda	<L93+nomatch_1
	and	#$ff
	bne	L125
	brl	L10039
L125:
	lda	|~~numbered
	and	#$ff
	bne	L126
	brl	L10040
L126:
	lda	<L93+first_1
	and	#$ff
	pha
	jsl	~~islower
	tax
	bne	L127
	brl	L10040
L127:
	lda	#$ff
	brl	L107
L10040:
	lda	|~~numbered
	and	#$ff
	beq	L128
	brl	L10041
L128:
	stz	<L93+n_1
	brl	L10045
L10044:
	ldx	<L93+n_1
	lda	<L93+keyword_1,X
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	ldx	<L93+n_1
	sta	<L93+keyword_1,X
	rep	#$20
	longa	on
L10042:
	inc	<L93+n_1
L10045:
	ldx	<L93+n_1
	lda	<L93+keyword_1,X
	and	#$ff
	beq	L129
	brl	L10044
L129:
L10043:
	sep	#$20
	longa	off
	lda	<L93+keyword_1
	sta	<L93+first_1
	rep	#$20
	longa	on
L10041:
	lda	<L93+first_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~command_start-130,X
	sta	<L93+n_1
	lda	<L93+n_1
	cmp	#<$ff
	beq	L130
	brl	L10046
L130:
	lda	#$ff
	brl	L107
L10046:
L10049:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~tokens+4,X
	sta	<L93+count_1
	lda	<L93+abbreviated_1
	and	#$ff
	bne	L131
	brl	L10050
L131:
	sec
	lda	<L93+kwlength_1
	sbc	<L93+count_1
	bvs	L132
	eor	#$8000
L132:
	bpl	L133
	brl	L10050
L133:
	lda	<L93+kwlength_1
	sta	<L93+count_1
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sec
	lda	<L93+kwlength_1
	ldx	<R0
	sbc	|~~tokens+6,X
	bvs	L134
	eor	#$8000
L134:
	bpl	L135
	brl	L10051
L135:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~tokens+6,X
	sta	<L93+count_1
L10051:
L10050:
	ldy	#$0
	lda	<L93+count_1
	bpl	L136
	dey
L136:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	#<~~tokens
	adc	<R1
	sta	<R2
	ldy	#$2
	lda	(<R2),Y
	pha
	lda	(<R2)
	pha
	pea	#0
	clc
	tdc
	adc	#<L93+keyword_1
	pha
	jsl	~~strncmp
	tax
	bne	L137
	brl	L10048
L137:
	inc	<L93+n_1
L10047:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#<~~tokens
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<R0
	ldy	#$2
	lda	(<R1),Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	<L93+first_1
	rep	#$20
	longa	on
	bne	L138
	brl	L10049
L138:
L10048:
	stz	<R0
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	#<~~tokens
	adc	<R1
	sta	<R2
	lda	(<R2)
	sta	<R1
	ldy	#$2
	lda	(<R2),Y
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	<L93+first_1
	rep	#$20
	longa	on
	bne	L140
	brl	L139
L140:
	inc	<R0
L139:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L93+nomatch_1
	rep	#$20
	longa	on
	lda	<L93+nomatch_1
	and	#$ff
	beq	L141
	brl	L10052
L141:
	lda	<L93+abbreviated_1
	and	#$ff
	bne	L142
	brl	L10052
L142:
	stz	<R0
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	sec
	lda	<L93+kwlength_1
	ldx	<R1
	sbc	|~~tokens+4,X
	bvs	L144
	eor	#$8000
L144:
	bpl	L145
	brl	L143
L145:
	inc	<R0
L143:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L93+abbreviated_1
	rep	#$20
	longa	on
L10052:
L10039:
	lda	<L93+nomatch_1
	and	#$ff
	beq	L147
	brl	L146
L147:
	lda	<L93+abbreviated_1
	and	#$ff
	beq	L148
	brl	L10053
L148:
	lda	<L93+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~tokens+12,X
	and	#$ff
	bne	L149
	brl	L10053
L149:
	ldx	<L93+count_1
	lda	<L93+keyword_1,X
	pha
	jsl	~~isidchar
	and	#$ff
	bne	L150
	brl	L10053
L150:
L146:
	lda	#$ff
	brl	L107
L10053:
	ldy	#$0
	lda	<L93+count_1
	bpl	L151
	dey
L151:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~lp
	adc	<R0
	sta	|~~lp
	lda	|~~lp+2
	adc	<R0+2
	sta	|~~lp+2
	lda	<L93+abbreviated_1
	and	#$ff
	bne	L152
	brl	L10054
L152:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L153
	brl	L10054
L153:
	inc	|~~lp
	bne	L154
	inc	|~~lp+2
L154:
L10054:
	lda	<L93+n_1
	brl	L107
L92	equ	36
L93	equ	13
	ends
	efunc
	code
	func
~~copy_keyword:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L155
	tcs
	phd
	tcd
token_0	set	4
toktype_1	set	0
tokvalue_1	set	1
	lda	|~~firstitem
	and	#$ff
	bne	L157
	brl	L10055
L157:
	lda	<L155+token_0
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+8,X
	sta	<L156+toktype_1
	rep	#$20
	longa	on
	lda	<L155+token_0
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+9,X
	sta	<L156+tokvalue_1
	rep	#$20
	longa	on
	lda	|~~linestart
	and	#$ff
	bne	L158
	brl	L10056
L158:
	lda	<L156+toktype_1
	and	#$ff
	beq	L159
	brl	L10056
L159:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$9f
	rep	#$20
	longa	on
	beq	L160
	brl	L10056
L160:
	sep	#$20
	longa	off
	lda	#$a1
	sta	<L156+tokvalue_1
	rep	#$20
	longa	on
L10056:
	brl	L10057
L10055:
	lda	<L155+token_0
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+10,X
	sta	<L156+toktype_1
	rep	#$20
	longa	on
	lda	<L155+token_0
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+11,X
	sta	<L156+tokvalue_1
	rep	#$20
	longa	on
L10057:
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	lda	<L156+toktype_1
	and	#$ff
	beq	L161
	brl	L10058
L161:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$9c
	rep	#$20
	longa	on
	bne	L163
	brl	L162
L163:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$bc
	rep	#$20
	longa	on
	bne	L164
	brl	L162
L164:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$c9
	rep	#$20
	longa	on
	beq	L165
	brl	L10059
L165:
L162:
	pea	#^L2
	pea	#<L2
	jsl	~~nextis
	and	#$ff
	bne	L166
	brl	L10059
L166:
	sep	#$20
	longa	off
	inc	<L156+tokvalue_1
	rep	#$20
	longa	on
	lda	|~~lp+2
	pha
	lda	|~~lp
	pha
	jsl	~~skip_blanks
	sta	<R0
	stx	<R0+2
	clc
	lda	#$2
	adc	<R0
	sta	|~~lp
	lda	#$0
	adc	<R0+2
	sta	|~~lp+2
	brl	L10060
L10059:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$c9
	rep	#$20
	longa	on
	beq	L167
	brl	L10061
L167:
	pea	#^L2+3
	pea	#<L2+3
	jsl	~~nextis
	and	#$ff
	bne	L168
	brl	L10061
L168:
	sep	#$20
	longa	off
	lda	#$cb
	sta	<L156+tokvalue_1
	rep	#$20
	longa	on
	lda	|~~lp+2
	pha
	lda	|~~lp
	pha
	jsl	~~skip_blanks
	sta	<R0
	stx	<R0+2
	clc
	lda	#$2
	adc	<R0
	sta	|~~lp
	lda	#$0
	adc	<R0+2
	sta	|~~lp+2
L10061:
L10060:
L10058:
	lda	<L156+toktype_1
	and	#$ff
	bne	L169
	brl	L10062
L169:
	pei	<L156+toktype_1
	jsl	~~store
L10062:
	pei	<L156+tokvalue_1
	jsl	~~store
	lda	<L155+token_0
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#<~~tokens
	adc	<R0
	sta	<R1
	lda	<L155+token_0
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#$ffff
	ldx	<R0
	adc	|~~tokens+4,X
	sta	<R2
	lda	(<R1)
	sta	<R3
	ldy	#$2
	lda	(<R1),Y
	sta	<R3+2
	sep	#$20
	longa	off
	ldy	<R2
	lda	[<R3],Y
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L170
	brl	L10063
L170:
	inc	|~~brackets
L10063:
	lda	<L156+toktype_1
	and	#$ff
	beq	L171
	brl	L10064
L171:
	lda	<L156+tokvalue_1
	and	#$ff
	brl	L10065
L10067:
L10068:
	lda	|~~lp+2
	pha
	lda	|~~lp
	pha
	jsl	~~copy_line
	sta	|~~lp
	stx	|~~lp+2
	brl	L10066
L10069:
L10070:
L10071:
L10072:
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~firstitem
	rep	#$20
	longa	on
	brl	L10066
L10073:
L10074:
L10075:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~isidchar
	and	#$ff
	bne	L172
	brl	L10076
L172:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L173
	inc	|~~lp+2
L173:
	brl	L10075
L10076:
	brl	L10066
L10065:
	xref	~~~swt
	jsl	~~~swt
	dw	8
	dw	153
	dw	L10068-1
	dw	159
	dw	L10071-1
	dw	173
	dw	L10073-1
	dw	197
	dw	L10072-1
	dw	205
	dw	L10074-1
	dw	209
	dw	L10067-1
	dw	210
	dw	L10070-1
	dw	223
	dw	L10069-1
	dw	L10066-1
L10066:
	brl	L10077
L10064:
	sep	#$20
	longa	off
	lda	<L156+toktype_1
	cmp	#<$fc
	rep	#$20
	longa	on
	beq	L174
	brl	L10078
L174:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$b
	rep	#$20
	longa	on
	bne	L176
	brl	L175
L176:
	sep	#$20
	longa	off
	lda	<L156+tokvalue_1
	cmp	#<$10
	rep	#$20
	longa	on
	beq	L177
	brl	L10079
L177:
L175:
	lda	|~~lp+2
	pha
	lda	|~~lp
	pha
	jsl	~~copy_line
	sta	|~~lp
	stx	|~~lp+2
L10079:
L10078:
L10077:
L178:
	lda	<L155+2
	sta	<L155+2+2
	lda	<L155+1
	sta	<L155+1+2
	pld
	tsc
	clc
	adc	#L155+2
	tcs
	rtl
L155	equ	18
L156	equ	17
	ends
	efunc
	data
L2:
	db	$42,$59,$00,$54,$4F,$00
	ends
	code
	func
~~copy_token:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L180
	tcs
	phd
	tcd
n_1	set	0
toktype_1	set	2
tokvalue_1	set	3
	sep	#$20
	longa	off
	stz	<L181+toktype_1
	rep	#$20
	longa	on
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L181+tokvalue_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L181+tokvalue_1
	cmp	#<$fc
	rep	#$20
	longa	on
	bcs	L182
	brl	L10080
L182:
	sep	#$20
	longa	off
	lda	<L181+tokvalue_1
	sta	<L181+toktype_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L183
	inc	|~~lp+2
L183:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L181+tokvalue_1
	rep	#$20
	longa	on
L10080:
	inc	|~~lp
	bne	L184
	inc	|~~lp+2
L184:
	lda	|~~firstitem
	and	#$ff
	bne	L185
	brl	L10081
L185:
	stz	<L181+n_1
	brl	L10085
L10084:
	lda	<L181+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+8,X
	cmp	<L181+toktype_1
	rep	#$20
	longa	on
	beq	L187
	brl	L186
L187:
	lda	<L181+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	sep	#$20
	longa	off
	ldx	<R1
	lda	|~~tokens+9,X
	cmp	<L181+tokvalue_1
	rep	#$20
	longa	on
	bne	L188
	brl	L10083
L188:
L186:
L10082:
	inc	<L181+n_1
L10085:
	lda	<L181+n_1
	cmp	#<$b7
	bcs	L189
	brl	L10084
L189:
L10083:
	brl	L10086
L10081:
	stz	<L181+n_1
	brl	L10090
L10089:
	lda	<L181+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+10,X
	cmp	<L181+toktype_1
	rep	#$20
	longa	on
	beq	L191
	brl	L190
L191:
	lda	<L181+n_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	sep	#$20
	longa	off
	ldx	<R1
	lda	|~~tokens+11,X
	cmp	<L181+tokvalue_1
	rep	#$20
	longa	on
	bne	L192
	brl	L10088
L192:
L190:
L10087:
	inc	<L181+n_1
L10090:
	lda	<L181+n_1
	cmp	#<$b7
	bcs	L193
	brl	L10089
L193:
L10088:
L10086:
	lda	<L181+n_1
	cmp	#<$b7
	bcc	L194
	brl	L10091
L194:
	pei	<L181+n_1
	jsl	~~copy_keyword
	brl	L10092
L10091:
	lda	#$5
	sta	|~~lasterror
	pea	#<$21
	pea	#4
	jsl	~~error
L10092:
L195:
	pld
	tsc
	clc
	adc	#L180
	tcs
	rtl
L180	equ	12
L181	equ	9
	ends
	efunc
	code
	func
~~copy_variable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L196
	tcs
	phd
	tcd
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$40
	rep	#$20
	longa	on
	bcs	L198
	brl	L10093
L198:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$5a
	cmp	[<R0]
	rep	#$20
	longa	on
	bcs	L199
	brl	L10093
L199:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$25
	rep	#$20
	longa	on
	beq	L200
	brl	L10093
L200:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$2
	lda	[<R0],Y
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L201
	brl	L10093
L201:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$2
	lda	[<R0],Y
	cmp	#<$5b
	rep	#$20
	longa	on
	bne	L202
	brl	L10093
L202:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L203
	inc	|~~lp+2
L203:
	brl	L10094
L10093:
	pea	#<$1
	jsl	~~store
L10095:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~isidchar
	and	#$ff
	bne	L204
	brl	L10096
L204:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L205
	inc	|~~lp+2
L205:
	brl	L10095
L10096:
L10094:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$25
	rep	#$20
	longa	on
	bne	L207
	brl	L206
L207:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$24
	rep	#$20
	longa	on
	beq	L208
	brl	L10097
L208:
L206:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L209
	inc	|~~lp+2
L209:
L10097:
L210:
	pld
	tsc
	clc
	adc	#L196
	tcs
	rtl
L196	equ	4
L197	equ	5
	ends
	efunc
	code
	func
~~copy_lineno:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L211
	tcs
	phd
	tcd
	pea	#<$1e
	jsl	~~store
	jsl	~~convert_lineno
	pha
	jsl	~~store_lineno
L213:
	pld
	tsc
	clc
	adc	#L211
	tcs
	rtl
L211	equ	0
L212	equ	1
	ends
	efunc
	code
	func
~~copy_number:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L214
	tcs
	phd
	tcd
ch_1	set	0
digits_1	set	1
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L215+ch_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L216
	inc	|~~lp+2
L216:
	pei	<L215+ch_1
	jsl	~~store
	stz	<L215+digits_1
	lda	<L215+ch_1
	and	#$ff
	brl	L10098
L10100:
L10101:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	pha
	jsl	~~isxdigit
	tax
	bne	L217
	brl	L10102
L217:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L218
	inc	|~~lp+2
L218:
	inc	<L215+digits_1
	brl	L10101
L10102:
	lda	<L215+digits_1
	beq	L219
	brl	L10103
L219:
	lda	#$5
	sta	|~~lasterror
	pea	#<$22
	pea	#4
	jsl	~~error
L10103:
	brl	L10099
L10104:
L10105:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$30
	rep	#$20
	longa	on
	bne	L221
	brl	L220
L221:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$31
	rep	#$20
	longa	on
	beq	L222
	brl	L10106
L222:
L220:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L223
	inc	|~~lp+2
L223:
	inc	<L215+digits_1
	brl	L10105
L10106:
	lda	<L215+digits_1
	beq	L224
	brl	L10107
L224:
	lda	#$5
	sta	|~~lasterror
	pea	#<$23
	pea	#4
	jsl	~~error
L10107:
	brl	L10099
L10108:
L10109:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L225
	brl	L10110
L225:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<R0]
	rep	#$20
	longa	on
	bcs	L226
	brl	L10110
L226:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L227
	inc	|~~lp+2
L227:
	brl	L10109
L10110:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L228
	brl	L10111
L228:
	pea	#<$2e
	jsl	~~store
	inc	|~~lp
	bne	L229
	inc	|~~lp+2
L229:
L10112:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L230
	brl	L10113
L230:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<R0]
	rep	#$20
	longa	on
	bcs	L231
	brl	L10113
L231:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L232
	inc	|~~lp+2
L232:
	brl	L10112
L10113:
L10111:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$65
	rep	#$20
	longa	on
	bne	L234
	brl	L233
L234:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$45
	rep	#$20
	longa	on
	beq	L235
	brl	L10114
L235:
L233:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	ldy	#$1
	lda	[<R0],Y
	and	#$ff
	pha
	jsl	~~isalpha
	tax
	beq	L236
	brl	L10114
L236:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L237
	inc	|~~lp+2
L237:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2b
	rep	#$20
	longa	on
	bne	L239
	brl	L238
L239:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L240
	brl	L10115
L240:
L238:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L241
	inc	|~~lp+2
L241:
L10115:
L10116:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L242
	brl	L10117
L242:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<R0]
	rep	#$20
	longa	on
	bcs	L243
	brl	L10117
L243:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L244
	inc	|~~lp+2
L244:
	inc	<L215+digits_1
	brl	L10116
L10117:
L10114:
	brl	L10099
L10098:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	37
	dw	L10104-1
	dw	38
	dw	L10100-1
	dw	L10108-1
L10099:
L245:
	pld
	tsc
	clc
	adc	#L214
	tcs
	rtl
L214	equ	7
L215	equ	5
	ends
	efunc
	code
	func
~~copy_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L246
	tcs
	phd
	tcd
	pea	#<$22
	jsl	~~store
	inc	|~~lp
	bne	L248
	inc	|~~lp+2
L248:
L10118:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L249
	brl	L10119
L249:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L250
	brl	L10120
L250:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L251
	brl	L10119
L251:
	pea	#<$22
	jsl	~~store
	clc
	lda	#$2
	adc	|~~lp
	sta	|~~lp
	bcc	L252
	inc	|~~lp+2
L252:
	brl	L10121
L10120:
	inc	|~~lp
	bne	L253
	inc	|~~lp+2
L253:
L10121:
	brl	L10118
L10119:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L254
	brl	L10122
L254:
	inc	|~~lp
	bne	L255
	inc	|~~lp+2
L255:
	brl	L10123
L10122:
	lda	#$2b
	sta	|~~lasterror
	pea	#<$2a
	pea	#4
	jsl	~~error
	pea	#<$22
	jsl	~~store
L10123:
L256:
	pld
	tsc
	clc
	adc	#L246
	tcs
	rtl
L246	equ	4
L247	equ	5
	ends
	efunc
	code
	func
~~copy_other:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L257
	tcs
	phd
	tcd
tclass_1	set	0
token_1	set	1
	sep	#$20
	longa	off
	stz	<L258+tclass_1
	rep	#$20
	longa	on
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L258+token_1
	rep	#$20
	longa	on
	lda	<L258+token_1
	and	#$ff
	brl	L10124
L10126:
	inc	|~~brackets
	brl	L10125
L10127:
	lda	|~~firstitem
	and	#$ff
	beq	L259
	brl	L10128
L259:
	inc	|~~brackets
L10128:
	brl	L10125
L10129:
	dec	|~~brackets
	lda	|~~brackets
	bmi	L260
	brl	L10130
L260:
	lda	#$28
	sta	|~~lasterror
	pea	#<$8a
	pea	#4
	jsl	~~error
L10130:
	brl	L10125
L10131:
	lda	|~~firstitem
	and	#$ff
	beq	L261
	brl	L10132
L261:
	dec	|~~brackets
	lda	|~~brackets
	bmi	L262
	brl	L10133
L262:
	lda	#$28
	sta	|~~lasterror
	pea	#<$8a
	pea	#4
	jsl	~~error
L10133:
L10132:
	brl	L10125
L10134:
	sep	#$20
	longa	off
	lda	#$ff
	sta	<L258+tclass_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$bf
	sta	<L258+token_1
	rep	#$20
	longa	on
	brl	L10125
L10135:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L263
	brl	L10136
L263:
	sep	#$20
	longa	off
	lda	#$8c
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L264
	inc	|~~lp+2
L264:
L10136:
	brl	L10125
L10137:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L265
	brl	L10138
L265:
	sep	#$20
	longa	off
	lda	#$88
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L266
	inc	|~~lp+2
L266:
L10138:
	brl	L10125
L10139:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	ldy	#$1
	lda	[<R0],Y
	and	#$ff
	brl	L10140
L10142:
	sep	#$20
	longa	off
	lda	#$84
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L267
	inc	|~~lp+2
L267:
	brl	L10141
L10143:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$2
	lda	[<R0],Y
	cmp	#<$3e
	rep	#$20
	longa	on
	beq	L268
	brl	L10144
L268:
	sep	#$20
	longa	off
	lda	#$87
	sta	<L258+token_1
	rep	#$20
	longa	on
	clc
	lda	#$2
	adc	|~~lp
	sta	|~~lp
	bcc	L269
	inc	|~~lp+2
L269:
	brl	L10145
L10144:
	sep	#$20
	longa	off
	lda	#$81
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L270
	inc	|~~lp+2
L270:
L10145:
	brl	L10141
L10140:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	61
	dw	L10142-1
	dw	62
	dw	L10143-1
	dw	L10141-1
L10141:
	brl	L10125
L10146:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	ldy	#$1
	lda	[<R0],Y
	and	#$ff
	brl	L10147
L10149:
	sep	#$20
	longa	off
	lda	#$85
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L271
	inc	|~~lp+2
L271:
	brl	L10148
L10150:
	sep	#$20
	longa	off
	lda	#$8a
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L272
	inc	|~~lp+2
L272:
	brl	L10148
L10151:
	sep	#$20
	longa	off
	lda	#$86
	sta	<L258+token_1
	rep	#$20
	longa	on
	inc	|~~lp
	bne	L273
	inc	|~~lp+2
L273:
	brl	L10148
L10147:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	60
	dw	L10151-1
	dw	61
	dw	L10149-1
	dw	62
	dw	L10150-1
	dw	L10148-1
L10148:
	brl	L10125
L10152:
	sep	#$20
	longa	off
	lda	<L258+token_1
	cmp	#<$20
	rep	#$20
	longa	on
	bcc	L274
	brl	L10153
L274:
	sep	#$20
	longa	off
	lda	<L258+token_1
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L275
	brl	L10153
L275:
	sep	#$20
	longa	off
	lda	#$20
	sta	<L258+token_1
	rep	#$20
	longa	on
L10153:
	brl	L10125
L10124:
	xref	~~~swt
	jsl	~~~swt
	dw	9
	dw	40
	dw	L10126-1
	dw	41
	dw	L10129-1
	dw	43
	dw	L10135-1
	dw	45
	dw	L10137-1
	dw	60
	dw	L10146-1
	dw	62
	dw	L10139-1
	dw	91
	dw	L10127-1
	dw	93
	dw	L10131-1
	dw	172
	dw	L10134-1
	dw	L10152-1
L10125:
	lda	<L258+tclass_1
	and	#$ff
	bne	L276
	brl	L10154
L276:
	pei	<L258+tclass_1
	jsl	~~store
L10154:
	pei	<L258+token_1
	jsl	~~store
	sep	#$20
	longa	off
	lda	<L258+token_1
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L277
	brl	L10155
L277:
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~firstitem
	rep	#$20
	longa	on
	brl	L10156
L10155:
	sep	#$20
	longa	off
	lda	<L258+token_1
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L278
	brl	L10157
L278:
	sep	#$20
	longa	off
	lda	<L258+token_1
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L279
	brl	L10157
L279:
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L10157:
L10156:
	inc	|~~lp
	bne	L280
	inc	|~~lp+2
L280:
L281:
	pld
	tsc
	clc
	adc	#L257
	tcs
	rtl
L257	equ	6
L258	equ	5
	ends
	efunc
	code
	func
~~tokenise_source:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L282
	tcs
	phd
	tcd
start_0	set	4
haslineno_0	set	8
token_1	set	0
ch_1	set	2
linenoposs_1	set	3
	stz	|~~next
	pea	#<$ffff
	jsl	~~store_lineno
	pea	#<$0
	jsl	~~store_linelen
	pea	#<$0
	jsl	~~store_exec
	stz	|~~brackets
	stz	|~~lasterror
	sep	#$20
	longa	off
	stz	<L283+linenoposs_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	|~~numbered
	rep	#$20
	longa	on
	pei	<L282+start_0+2
	pei	<L282+start_0
	jsl	~~skip_blanks
	sta	|~~lp
	stx	|~~lp+2
	lda	<L282+haslineno_0
	and	#$ff
	bne	L284
	brl	L10158
L284:
	stz	|~~next
	stz	<R0
	lda	|~~lp
	sta	<R1
	lda	|~~lp+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L286
	brl	L285
L286:
	lda	|~~lp
	sta	<R1
	lda	|~~lp+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<R1]
	rep	#$20
	longa	on
	bcs	L287
	brl	L285
L287:
	inc	<R0
L285:
	sep	#$20
	longa	off
	lda	<R0
	sta	|~~numbered
	rep	#$20
	longa	on
	lda	|~~numbered
	and	#$ff
	bne	L288
	brl	L10159
L288:
	jsl	~~convert_lineno
	pha
	jsl	~~store_lineno
L10159:
	lda	|~~basicvars+429
	bit	#$2
	bne	L289
	brl	L10160
L289:
	lda	|~~lp+2
	pha
	lda	|~~lp
	pha
	jsl	~~skip_blanks
	sta	|~~lp
	stx	|~~lp+2
	brl	L10161
L10160:
L10162:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L291
	brl	L290
L291:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L292
	brl	L10163
L292:
L290:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~store
	inc	|~~lp
	bne	L293
	inc	|~~lp+2
L293:
	brl	L10162
L10163:
L10161:
L10158:
	lda	#$6
	sta	|~~next
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L283+ch_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~firstitem
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~linestart
	rep	#$20
	longa	on
L10164:
	lda	<L283+ch_1
	and	#$ff
	bne	L294
	brl	L10165
L294:
	pei	<L283+ch_1
	jsl	~~isidstart
	and	#$ff
	bne	L295
	brl	L10166
L295:
	lda	<L283+ch_1
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	sec
	lda	<R0
	sbc	#<$41
	bvs	L296
	eor	#$8000
L296:
	bmi	L297
	brl	L10167
L297:
	lda	<L283+ch_1
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	sec
	lda	#$58
	sbc	<R0
	bvs	L298
	eor	#$8000
L298:
	bmi	L299
	brl	L10167
L299:
	jsl	~~kwsearch
	sta	<L283+token_1
	brl	L10168
L10167:
	lda	#$ff
	sta	<L283+token_1
L10168:
	lda	<L283+token_1
	cmp	#<$ff
	bne	L300
	brl	L10169
L300:
	pei	<L283+token_1
	jsl	~~copy_keyword
	lda	<L283+token_1
	ldx	#<$e
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	|~~tokens+13,X
	sta	<L283+linenoposs_1
	rep	#$20
	longa	on
	brl	L10170
L10169:
	jsl	~~copy_variable
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L283+linenoposs_1
	rep	#$20
	longa	on
L10170:
	brl	L10171
L10166:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$40
	rep	#$20
	longa	on
	beq	L301
	brl	L10172
L301:
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$25
	rep	#$20
	longa	on
	beq	L302
	brl	L10172
L302:
	jsl	~~copy_variable
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L283+linenoposs_1
	rep	#$20
	longa	on
	brl	L10173
L10172:
	lda	<L283+linenoposs_1
	and	#$ff
	bne	L303
	brl	L10174
L303:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L304
	brl	L10174
L304:
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L283+ch_1
	rep	#$20
	longa	on
	bcs	L305
	brl	L10174
L305:
	jsl	~~copy_lineno
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	brl	L10175
L10174:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L308
	brl	L307
L308:
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L283+ch_1
	rep	#$20
	longa	on
	bcc	L309
	brl	L306
L309:
L307:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$26
	rep	#$20
	longa	on
	bne	L310
	brl	L306
L310:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$25
	rep	#$20
	longa	on
	bne	L311
	brl	L306
L311:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L312
	brl	L10176
L312:
L306:
	jsl	~~copy_number
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L283+linenoposs_1
	rep	#$20
	longa	on
	brl	L10177
L10176:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L313
	brl	L10178
L313:
	jsl	~~copy_string
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L283+linenoposs_1
	rep	#$20
	longa	on
	brl	L10179
L10178:
	lda	|~~firstitem
	and	#$ff
	bne	L314
	brl	L10180
L314:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$2a
	rep	#$20
	longa	on
	beq	L315
	brl	L10180
L315:
	pea	#<$d8
	jsl	~~store
	clc
	lda	#$1
	adc	|~~lp
	sta	<R0
	lda	#$0
	adc	|~~lp+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~copy_line
	sta	|~~lp
	stx	|~~lp+2
	brl	L10181
L10180:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$80
	rep	#$20
	longa	on
	bcs	L316
	brl	L10182
L316:
	jsl	~~copy_token
	brl	L10183
L10182:
	jsl	~~copy_other
	stz	<R0
	lda	<L283+linenoposs_1
	and	#$ff
	bne	L318
	brl	L317
L318:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L320
	brl	L319
L320:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L321
	brl	L319
L321:
	sep	#$20
	longa	off
	lda	<L283+ch_1
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L322
	brl	L317
L322:
L319:
	inc	<R0
L317:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L283+linenoposs_1
	rep	#$20
	longa	on
L10183:
L10181:
L10179:
L10177:
L10175:
L10173:
L10171:
	sep	#$20
	longa	off
	stz	|~~linestart
	rep	#$20
	longa	on
	lda	|~~lp
	sta	<R0
	lda	|~~lp+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L283+ch_1
	rep	#$20
	longa	on
	brl	L10164
L10165:
	pea	#<$0
	jsl	~~store
	lda	|~~next
	pha
	jsl	~~store_exec
	pea	#<$0
	jsl	~~store
	lda	|~~next
	pha
	jsl	~~store_linelen
	dec	|~~next
	lda	|~~brackets
	bmi	L323
	brl	L10184
L323:
	lda	#$28
	sta	|~~lasterror
	pea	#<$89
	pea	#4
	jsl	~~error
	brl	L10185
L10184:
	sec
	lda	#$0
	sbc	|~~brackets
	bvs	L324
	eor	#$8000
L324:
	bpl	L325
	brl	L10186
L325:
	lda	#$29
	sta	|~~lasterror
	pea	#<$88
	pea	#4
	jsl	~~error
L10186:
L10185:
L326:
	lda	<L282+2
	sta	<L282+2+6
	lda	<L282+1
	sta	<L282+1+6
	pld
	tsc
	clc
	adc	#L282+6
	tcs
	rtl
L282	equ	12
L283	equ	9
	ends
	efunc
	code
	func
~~do_keyword:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L327
	tcs
	phd
	tcd
token_1	set	0
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	sta	<L328+token_1
	rep	#$20
	longa	on
	inc	|~~source
	sep	#$20
	longa	off
	lda	<L328+token_1
	cmp	#<$fc
	rep	#$20
	longa	on
	bcs	L329
	brl	L10187
L329:
	pei	<L328+token_1
	jsl	~~store
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	pha
	jsl	~~store
	sep	#$20
	longa	off
	lda	<L328+token_1
	cmp	#<$fc
	rep	#$20
	longa	on
	beq	L330
	brl	L10188
L330:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$b
	rep	#$20
	longa	on
	bne	L332
	brl	L331
L332:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$10
	rep	#$20
	longa	on
	beq	L333
	brl	L10188
L333:
L331:
L10191:
	inc	|~~source
L10189:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L334
	brl	L10191
L334:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L335
	brl	L10191
L335:
L10190:
	clc
	lda	#$ffff
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	|~~source
	pha
	jsl	~~store_shortoffset
	lda	#$ffff
	sta	|~~source
	brl	L10192
L10188:
	inc	|~~source
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L10192:
	brl	L10193
L10187:
	pei	<L328+token_1
	jsl	~~store
	stz	<R0
	sep	#$20
	longa	off
	lda	<L328+token_1
	cmp	#<$d2
	rep	#$20
	longa	on
	bne	L338
	brl	L337
L338:
	sep	#$20
	longa	off
	lda	<L328+token_1
	cmp	#<$df
	rep	#$20
	longa	on
	bne	L339
	brl	L337
L339:
	sep	#$20
	longa	off
	lda	<L328+token_1
	cmp	#<$9f
	rep	#$20
	longa	on
	bne	L340
	brl	L337
L340:
	sep	#$20
	longa	off
	lda	<L328+token_1
	cmp	#<$c5
	rep	#$20
	longa	on
	beq	L341
	brl	L336
L341:
L337:
	inc	<R0
L336:
	sep	#$20
	longa	off
	lda	<R0
	sta	|~~firstitem
	rep	#$20
	longa	on
	lda	<L328+token_1
	and	#$ff
	brl	L10194
L10196:
	pea	#<$0
	jsl	~~store_shortoffset
	pea	#<$0
	jsl	~~store_shortoffset
	brl	L10195
L10197:
L10198:
L10199:
L10200:
L10201:
	pea	#<$0
	jsl	~~store_shortoffset
	brl	L10195
L10202:
	pea	#<$0
	jsl	~~store_longoffset
	brl	L10195
L10203:
L10204:
	dec	|~~next
	pea	#<$c
	jsl	~~store
	sec
	lda	|~~next
	sbc	|~~source
	pha
	jsl	~~store_longoffset
L10205:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	pha
	jsl	~~isident
	and	#$ff
	bne	L342
	brl	L10206
L342:
	inc	|~~source
	brl	L10205
L10206:
	brl	L10195
L10207:
	dec	|~~next
	lda	#$ffff
	sta	|~~source
	brl	L10195
L10208:
	clc
	lda	#$ffff
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	|~~source
	pha
	jsl	~~store_shortoffset
	lda	#$ffff
	sta	|~~source
	brl	L10195
L10209:
L10210:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L344
	brl	L343
L344:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L345
	brl	L10211
L345:
L343:
	inc	|~~source
	brl	L10210
L10211:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$80
	ldy	|~~source
	cmp	[<R0],Y
	rep	#$20
	longa	on
	bcc	L346
	brl	L10212
L346:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	pha
	jsl	~~store
	inc	|~~source
L10212:
	brl	L10195
L10194:
	xref	~~~swt
	jsl	~~~swt
	dw	12
	dw	144
	dw	L10202-1
	dw	153
	dw	L10208-1
	dw	159
	dw	L10197-1
	dw	161
	dw	L10198-1
	dw	173
	dw	L10203-1
	dw	178
	dw	L10196-1
	dw	197
	dw	L10200-1
	dw	205
	dw	L10204-1
	dw	209
	dw	L10207-1
	dw	226
	dw	L10209-1
	dw	233
	dw	L10199-1
	dw	235
	dw	L10201-1
	dw	L10195-1
L10195:
L10193:
L347:
	pld
	tsc
	clc
	adc	#L327
	tcs
	rtl
L327	equ	5
L328	equ	5
	ends
	efunc
	code
	func
~~do_statvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L348
	tcs
	phd
	tcd
first_1	set	0
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	sta	<L349+first_1
	rep	#$20
	longa	on
	clc
	lda	#$2
	adc	|~~source
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<R1],Y
	cmp	#<$3f
	rep	#$20
	longa	on
	bne	L351
	brl	L350
L351:
	clc
	lda	#$2
	adc	|~~source
	sta	<R1
	lda	|~~tokenbase
	sta	<R2
	lda	|~~tokenbase+2
	sta	<R2+2
	sep	#$20
	longa	off
	ldy	<R1
	lda	[<R2],Y
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L352
	brl	L10213
L352:
L350:
	pea	#<$b
	jsl	~~store
	brl	L10214
L10213:
	pea	#<$2
	jsl	~~store
L10214:
	lda	<L349+first_1
	and	#$ff
	sta	<R0
	clc
	lda	#$ffc0
	adc	<R0
	pha
	jsl	~~store
	inc	|~~source
	inc	|~~source
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L353:
	pld
	tsc
	clc
	adc	#L348
	tcs
	rtl
L348	equ	13
L349	equ	13
	ends
	efunc
	code
	func
~~do_dynamvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L354
	tcs
	phd
	tcd
	inc	|~~source
	pea	#<$1
	jsl	~~store
	clc
	lda	#$ffff
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	|~~source
	pha
	jsl	~~store_longoffset
L10215:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	pha
	jsl	~~isident
	and	#$ff
	bne	L356
	brl	L10216
L356:
	inc	|~~source
	brl	L10215
L10216:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$25
	rep	#$20
	longa	on
	bne	L358
	brl	L357
L358:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$24
	rep	#$20
	longa	on
	beq	L359
	brl	L10217
L359:
L357:
	inc	|~~source
L10217:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L361
	brl	L360
L361:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	L362
	brl	L10218
L362:
L360:
	inc	|~~source
L10218:
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L363:
	pld
	tsc
	clc
	adc	#L354
	tcs
	rtl
L354	equ	4
L355	equ	5
	ends
	efunc
	code
	func
~~do_linenumber:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L364
	tcs
	phd
	tcd
line_1	set	0
	clc
	lda	#$2
	adc	|~~source
	sta	<R1
	lda	|~~tokenbase
	sta	<R2
	lda	|~~tokenbase+2
	sta	<R2+2
	ldy	<R1
	lda	[<R2],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R0
	lda	|~~source
	ina
	sta	<R2
	lda	|~~tokenbase
	sta	<R3
	lda	|~~tokenbase+2
	sta	<R3+2
	ldy	<R2
	lda	[<R3],Y
	and	#$ff
	sta	<R3
	clc
	lda	<R3
	adc	<R0
	sta	<L365+line_1
	pea	#<$1e
	jsl	~~store
	pei	<L365+line_1
	jsl	~~store_longoffset
	inc	|~~source
	inc	|~~source
	inc	|~~source
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L366:
	pld
	tsc
	clc
	adc	#L364
	tcs
	rtl
L364	equ	18
L365	equ	17
	ends
	efunc
	code
	func
~~do_number:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L367
	tcs
	phd
	tcd
	udata
L10219:
	ds	4
	ends
value_1	set	0
isintvalue_1	set	2
p_1	set	3
	stz	<L368+value_1
	sep	#$20
	longa	off
	lda	#$1
	sta	<L368+isintvalue_1
	rep	#$20
	longa	on
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	and	#$ff
	brl	L10220
L10222:
	inc	|~~source
L10223:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	and	#$ff
	pha
	jsl	~~isxdigit
	tax
	bne	L369
	brl	L10224
L369:
	lda	<L368+value_1
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	ldy	|~~source
	lda	[<R1],Y
	pha
	jsl	~~todigit
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<L368+value_1
	inc	|~~source
	brl	L10223
L10224:
	brl	L10221
L10225:
	inc	|~~source
L10226:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$30
	rep	#$20
	longa	on
	bne	L371
	brl	L370
L371:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$31
	rep	#$20
	longa	on
	beq	L372
	brl	L10227
L372:
L370:
	lda	<L368+value_1
	asl	A
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	ldy	|~~source
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L368+value_1
	inc	|~~source
	brl	L10226
L10227:
	brl	L10221
L10228:
	lda	#<L10219
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L368+value_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L368+isintvalue_1
	pha
	ldy	#$0
	lda	|~~source
	bpl	L373
	dey
L373:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~tokenbase
	adc	<R1
	sta	<R2
	lda	|~~tokenbase+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~tonumber
	sta	<L368+p_1
	stx	<L368+p_1+2
	lda	<L368+p_1
	ora	<L368+p_1+2
	beq	L374
	brl	L10229
L374:
	lda	#$51
	sta	|~~lasterror
	pei	<L368+value_1
	pea	#4
	jsl	~~error
L375:
	pld
	tsc
	clc
	adc	#L367
	tcs
	rtl
L10229:
	sec
	lda	<L368+p_1
	sbc	|~~tokenbase
	sta	<R0
	lda	<L368+p_1+2
	sbc	|~~tokenbase+2
	sta	<R0+2
	lda	<R0
	sta	|~~source
	brl	L10221
L10220:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	37
	dw	L10225-1
	dw	38
	dw	L10222-1
	dw	L10228-1
L10221:
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	lda	<L368+isintvalue_1
	and	#$ff
	bne	L376
	brl	L10230
L376:
	lda	<L368+value_1
	beq	L377
	brl	L10231
L377:
	pea	#<$10
	jsl	~~store
	brl	L10232
L10231:
	lda	<L368+value_1
	cmp	#<$1
	beq	L378
	brl	L10233
L378:
	pea	#<$11
	jsl	~~store
	brl	L10234
L10233:
	sec
	lda	#$1
	sbc	<L368+value_1
	bvs	L379
	eor	#$8000
L379:
	bpl	L380
	brl	L10235
L380:
	sec
	lda	#$100
	sbc	<L368+value_1
	bvs	L381
	eor	#$8000
L381:
	bmi	L382
	brl	L10235
L382:
	pea	#<$12
	jsl	~~store
	clc
	lda	#$ffff
	adc	<L368+value_1
	pha
	jsl	~~store
	brl	L10236
L10235:
	pea	#<$13
	jsl	~~store
	pei	<L368+value_1
	jsl	~~store_intconst
L10236:
L10234:
L10232:
	brl	L10237
L10230:
	lda	|L10219+2
	pha
	lda	|L10219
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L383
	brl	L10238
L383:
	pea	#<$14
	jsl	~~store
	brl	L10239
L10238:
	pea	#$3FF0
	pea	#$0000
	pea	#$0000
	pea	#$0000
	lda	|L10219+2
	pha
	lda	|L10219
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dcmp
	jsl	~~~dcmp
	beq	L384
	brl	L10240
L384:
	pea	#<$15
	jsl	~~store
	brl	L10241
L10240:
	pea	#<$16
	jsl	~~store
	lda	|L10219+2
	pha
	lda	|L10219
	pha
	jsl	~~store_fpvalue
L10241:
L10239:
L10237:
	brl	L375
L367	equ	19
L368	equ	13
	ends
	efunc
	code
	func
~~do_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L385
	tcs
	phd
	tcd
start_1	set	0
length_1	set	2
quotes_1	set	4
	inc	|~~source
	lda	|~~source
	sta	<L386+start_1
	sep	#$20
	longa	off
	stz	<L386+quotes_1
	rep	#$20
	longa	on
	stz	<L386+length_1
L10242:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L387
	brl	L10244
L387:
	inc	|~~source
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L388
	brl	L10243
L388:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L386+quotes_1
	rep	#$20
	longa	on
L10244:
	inc	|~~source
	inc	<L386+length_1
	brl	L10242
L10243:
	lda	<L386+quotes_1
	and	#$ff
	bne	L389
	brl	L10245
L389:
	pea	#<$18
	jsl	~~store
	brl	L10246
L10245:
	pea	#<$17
	jsl	~~store
L10246:
	clc
	lda	#$ffff
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	<L386+start_1
	pha
	jsl	~~store_shortoffset
	pei	<L386+length_1
	jsl	~~store_size
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L390:
	pld
	tsc
	clc
	adc	#L385
	tcs
	rtl
L385	equ	9
L386	equ	5
	ends
	efunc
	code
	func
~~do_star:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L391
	tcs
	phd
	tcd
L10249:
	inc	|~~source
L10247:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L393
	brl	L10249
L393:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L394
	brl	L10249
L394:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$2a
	rep	#$20
	longa	on
	bne	L395
	brl	L10249
L395:
L10248:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	ldy	|~~source
	lda	[<R0],Y
	and	#$ff
	bne	L396
	brl	L10250
L396:
	pea	#<$d8
	jsl	~~store
	clc
	lda	#$ffff
	adc	|~~next
	sta	<R0
	sec
	lda	<R0
	sbc	|~~source
	pha
	jsl	~~store_shortoffset
	lda	#$ffff
	sta	|~~source
L10250:
L397:
	pld
	tsc
	clc
	adc	#L391
	tcs
	rtl
L391	equ	4
L392	equ	5
	ends
	efunc
	code
	func
~~translate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L398
	tcs
	phd
	tcd
token_1	set	0
	lda	#$6
	sta	|~~source
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	sta	<L399+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~firstitem
	rep	#$20
	longa	on
L10251:
	lda	<L399+token_1
	and	#$ff
	bne	L400
	brl	L10252
L400:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$d8
	rep	#$20
	longa	on
	beq	L401
	brl	L10253
L401:
	jsl	~~do_star
	brl	L10254
L10253:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$80
	rep	#$20
	longa	on
	bcs	L402
	brl	L10255
L402:
	jsl	~~do_keyword
	brl	L10256
L10255:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$40
	rep	#$20
	longa	on
	bcs	L403
	brl	L10257
L403:
	sep	#$20
	longa	off
	lda	#$5a
	cmp	<L399+token_1
	rep	#$20
	longa	on
	bcs	L404
	brl	L10257
L404:
	lda	|~~source
	ina
	sta	<R0
	lda	|~~tokenbase
	sta	<R1
	lda	|~~tokenbase+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<R1],Y
	cmp	#<$25
	rep	#$20
	longa	on
	beq	L405
	brl	L10257
L405:
	jsl	~~do_statvar
	brl	L10258
L10257:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L406
	brl	L10259
L406:
	jsl	~~do_dynamvar
	brl	L10260
L10259:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L408
	brl	L407
L408:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$5d
	rep	#$20
	longa	on
	beq	L409
	brl	L10261
L409:
L407:
	lda	|~~firstitem
	and	#$ff
	beq	L410
	brl	L10262
L410:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$5d
	rep	#$20
	longa	on
	beq	L411
	brl	L10262
L411:
	sep	#$20
	longa	off
	lda	#$29
	sta	<L399+token_1
	rep	#$20
	longa	on
L10262:
	pei	<L399+token_1
	jsl	~~store
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
	inc	|~~source
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L412
	brl	L10263
L412:
L10264:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L414
	brl	L413
L414:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L415
	brl	L10265
L415:
L413:
	inc	|~~source
	brl	L10264
L10265:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L416
	brl	L10266
L416:
	pea	#<$2e
	jsl	~~store
	inc	|~~source
L10266:
L10263:
	brl	L10267
L10261:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L417
	brl	L10268
L417:
	jsl	~~do_linenumber
	brl	L10269
L10268:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L420
	brl	L419
L420:
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L399+token_1
	rep	#$20
	longa	on
	bcc	L421
	brl	L418
L421:
L419:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$2e
	rep	#$20
	longa	on
	bne	L422
	brl	L418
L422:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$26
	rep	#$20
	longa	on
	bne	L423
	brl	L418
L423:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$25
	rep	#$20
	longa	on
	beq	L424
	brl	L10270
L424:
L418:
	jsl	~~do_number
	brl	L10271
L10270:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L425
	brl	L10272
L425:
	jsl	~~do_string
	brl	L10273
L10272:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L427
	brl	L426
L427:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L428
	brl	L10274
L428:
L426:
	inc	|~~source
	brl	L10275
L10274:
	sep	#$20
	longa	off
	lda	<L399+token_1
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L429
	brl	L10276
L429:
	pea	#<$3a
	jsl	~~store
L10279:
	inc	|~~source
L10277:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L430
	brl	L10279
L430:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L431
	brl	L10279
L431:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L432
	brl	L10279
L432:
L10278:
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~firstitem
	rep	#$20
	longa	on
	brl	L10280
L10276:
	pei	<L399+token_1
	jsl	~~store
	inc	|~~source
	sep	#$20
	longa	off
	stz	|~~firstitem
	rep	#$20
	longa	on
L10280:
L10275:
L10273:
L10271:
L10269:
L10267:
L10260:
L10258:
L10256:
L10254:
	lda	|~~source
	cmp	#<$ffffffff
	bne	L433
	brl	L10252
L433:
	sec
	lda	#$0
	sbc	|~~lasterror
	bvs	L434
	eor	#$8000
L434:
	bmi	L435
	brl	L10252
L435:
	lda	|~~tokenbase
	sta	<R0
	lda	|~~tokenbase+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	|~~source
	lda	[<R0],Y
	sta	<L399+token_1
	rep	#$20
	longa	on
	brl	L10251
L10252:
	pea	#<$0
	jsl	~~store
	lda	|~~next
	pha
	jsl	~~store_linelen
L436:
	pld
	tsc
	clc
	adc	#L398
	tcs
	rtl
L398	equ	9
L399	equ	9
	ends
	efunc
	code
	func
~~mark_badline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L437
	tcs
	phd
	tcd
	lda	|~~tokenbase+2
	pha
	lda	|~~tokenbase
	pha
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	#<$ffff
	beq	L439
	brl	L10281
L439:
	pea	#<$a3
	jsl	~~store
	brl	L10282
L10281:
	pea	#<$fd
	jsl	~~store
	lda	|~~lasterror
	pha
	jsl	~~store
L10282:
	pea	#<$0
	jsl	~~store
	lda	|~~next
	pha
	jsl	~~store_linelen
L440:
	pld
	tsc
	clc
	adc	#L437
	tcs
	rtl
L437	equ	4
L438	equ	5
	ends
	efunc
	code
	xdef	~~tokenize
	func
~~tokenize:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L441
	tcs
	phd
	tcd
start_0	set	4
tokenbuf_0	set	8
haslineno_0	set	12
	lda	<L441+tokenbuf_0
	sta	|~~tokenbase
	lda	<L441+tokenbuf_0+2
	sta	|~~tokenbase+2
	pei	<L441+haslineno_0
	pei	<L441+start_0+2
	pei	<L441+start_0
	jsl	~~tokenise_source
	sec
	lda	#$0
	sbc	|~~lasterror
	bvs	L443
	eor	#$8000
L443:
	bpl	L444
	brl	L10283
L444:
	jsl	~~mark_badline
	brl	L10284
L10283:
	jsl	~~translate
L10284:
L445:
	lda	<L441+2
	sta	<L441+2+10
	lda	<L441+1
	sta	<L441+1+10
	pld
	tsc
	clc
	adc	#L441+10
	tcs
	rtl
L441	equ	0
L442	equ	1
	ends
	efunc
	data
~~skiptable:
	dw	$0,$4,$1,$4,$4,$4,$4,$4,$4,$4
	dw	$4,$1,$4,$4,$FFFF,$FFFF,$0,$0,$1,$4
	dw	$0,$0,$4,$4,$4,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$4,$4,$FFFF,$0,$FFFF,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$0,$0
	dw	$0,$0,$0,$0,$0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$0,$0,$0,$0,$0,$0,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$0,$0,$0,$0,$FFFF,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$4,$4,$0,$0,$0,$0
	dw	$0,$0,$0,$2,$0,$0,$0,$0,$0,$2
	dw	$2,$2,$2,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$4,$4
	dw	$4,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$2,$2,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$2,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$2,$2,$2,$2,$0,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dw	$FFFF,$FFFF,$1,$1,$1,$1
	ends
	code
	xdef	~~skip_token
	func
~~skip_token:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L446
	tcs
	phd
	tcd
p_0	set	4
size_1	set	0
	lda	[<L446+p_0]
	and	#$ff
	beq	L448
	brl	L10285
L448:
	ldx	<L446+p_0+2
	lda	<L446+p_0
L449:
	tay
	lda	<L446+2
	sta	<L446+2+4
	lda	<L446+1
	sta	<L446+1+4
	pld
	tsc
	clc
	adc	#L446+4
	tcs
	tya
	rtl
L10285:
	lda	[<L446+p_0]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~skiptable,X
	sta	<L447+size_1
	lda	<L447+size_1
	bpl	L450
	brl	L10286
L450:
	ldy	#$0
	lda	<L447+size_1
	bpl	L451
	dey
L451:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	clc
	lda	<L446+p_0
	adc	<R1
	sta	<R0
	lda	<L446+p_0+2
	adc	<R1+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L449
L10286:
	pea	#<$7
	pea	#4
	jsl	~~error
	lda	#$0
	tax
	lda	#$0
	brl	L449
L446	equ	10
L447	equ	9
	ends
	efunc
	code
	xdef	~~skip_name
	func
~~skip_name:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L452
	tcs
	phd
	tcd
p_0	set	4
L10289:
	inc	<L452+p_0
	bne	L454
	inc	<L452+p_0+2
L454:
L10287:
	lda	[<L452+p_0]
	and	#$ff
	pha
	jsl	~~isalnum
	tax
	beq	L455
	brl	L10289
L455:
	sep	#$20
	longa	off
	lda	[<L452+p_0]
	cmp	#<$5f
	rep	#$20
	longa	on
	bne	L456
	brl	L10289
L456:
	sep	#$20
	longa	off
	lda	[<L452+p_0]
	cmp	#<$60
	rep	#$20
	longa	on
	bne	L457
	brl	L10289
L457:
L10288:
	sep	#$20
	longa	off
	lda	[<L452+p_0]
	cmp	#<$25
	rep	#$20
	longa	on
	bne	L459
	brl	L458
L459:
	sep	#$20
	longa	off
	lda	[<L452+p_0]
	cmp	#<$24
	rep	#$20
	longa	on
	beq	L460
	brl	L10290
L460:
L458:
	inc	<L452+p_0
	bne	L461
	inc	<L452+p_0+2
L461:
L10290:
	sep	#$20
	longa	off
	lda	[<L452+p_0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L463
	brl	L462
L463:
	sep	#$20
	longa	off
	lda	[<L452+p_0]
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	L464
	brl	L10291
L464:
L462:
	inc	<L452+p_0
	bne	L465
	inc	<L452+p_0+2
L465:
L10291:
	ldx	<L452+p_0+2
	lda	<L452+p_0
L466:
	tay
	lda	<L452+2
	sta	<L452+2+4
	lda	<L452+1
	sta	<L452+1+4
	pld
	tsc
	clc
	adc	#L452+4
	tcs
	tya
	rtl
L452	equ	0
L453	equ	1
	ends
	efunc
	code
	xdef	~~get_intvalue
	func
~~get_intvalue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L467
	tcs
	phd
	tcd
ip_0	set	4
	ldy	#$1
	lda	[<L467+ip_0],Y
	and	#$ff
	sta	<R0
	ldy	#$2
	lda	[<L467+ip_0],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$3
	lda	[<L467+ip_0],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	ldy	#$4
	lda	[<L467+ip_0],Y
	and	#$ff
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R1
L469:
	tay
	lda	<L467+2
	sta	<L467+2+4
	lda	<L467+1
	sta	<L467+1+4
	pld
	tsc
	clc
	adc	#L467+4
	tcs
	tya
	rtl
L467	equ	12
L468	equ	13
	ends
	efunc
	code
	xdef	~~get_address
	func
~~get_address:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L470
	tcs
	phd
	tcd
p_0	set	4
	ldy	#$1
	lda	[<L470+p_0],Y
	and	#$ff
	sta	<R0
	ldy	#$2
	lda	[<L470+p_0],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$3
	lda	[<L470+p_0],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	ldy	#$4
	lda	[<L470+p_0],Y
	and	#$ff
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R1
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L472
	dey
L472:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<R1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L473:
	tay
	lda	<L470+2
	sta	<L470+2+4
	lda	<L470+1
	sta	<L470+1+4
	pld
	tsc
	clc
	adc	#L470+4
	tcs
	tya
	rtl
L470	equ	12
L471	equ	13
	ends
	efunc
	code
	xdef	~~get_linenum
	func
~~get_linenum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L474
	tcs
	phd
	tcd
lp_0	set	4
	ldy	#$1
	lda	[<L474+lp_0],Y
	and	#$ff
	sta	<R0
	ldy	#$2
	lda	[<L474+lp_0],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
L476:
	tay
	lda	<L474+2
	sta	<L474+2+4
	lda	<L474+1
	sta	<L474+1+4
	pld
	tsc
	clc
	adc	#L474+4
	tcs
	tya
	rtl
L474	equ	12
L475	equ	13
	ends
	efunc
	code
	func
~~set_linenum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L477
	tcs
	phd
	tcd
lp_0	set	4
line_0	set	8
	sep	#$20
	longa	off
	lda	<L477+line_0
	ldy	#$1
	sta	[<L477+lp_0],Y
	rep	#$20
	longa	on
	lda	<L477+line_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$2
	sta	[<L477+lp_0],Y
	rep	#$20
	longa	on
L479:
	lda	<L477+2
	sta	<L477+2+6
	lda	<L477+1
	sta	<L477+1+6
	pld
	tsc
	clc
	adc	#L477+6
	tcs
	rtl
L477	equ	0
L478	equ	1
	ends
	efunc
	code
	xdef	~~get_fpvalue
	func
~~get_fpvalue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L480
	tcs
	phd
	tcd
fp_0	set	4
	udata
L10292:
	ds	4
	ends
	pea	#^$4
	pea	#<$4
	clc
	lda	#$1
	adc	<L480+fp_0
	sta	<R0
	lda	#$0
	adc	<L480+fp_0+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#<L10292
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~memcpy
	lda	|L10292
	sta	<L480+8
	lda	|L10292+2
	sta	<L480+10
L482:
	lda	<L480+2
	sta	<L480+2+4
	lda	<L480+1
	sta	<L480+1+4
	pld
	tsc
	clc
	adc	#L480+4
	tcs
	rtl
L480	equ	8
L481	equ	9
	ends
	efunc
	data
~~onebytelist:
	dl	L179+0
	dl	L179+4
	dl	L179+7
	dl	L179+11
	dl	L179+15
	dl	L179+18
	dl	L179+21
	dl	L179+24
	dl	L179+28
	dl	L179+31
	dl	L179+35
	dl	L179+38
	dl	L179+41
	dl	L179+44
	dl	L179+50
	dl	L179+55
	dl	L179+60
	dl	L179+65
	dl	L179+70
	dl	L179+76
	dl	L179+83
	dl	L179+87
	dl	L179+93
	dl	L179+99
	dl	L179+103
	dl	L179+110
	dl	L179+115
	dl	L179+119
	dl	L179+123
	dl	L179+128
	dl	L179+136
	dl	L179+144
	dl	L179+149
	dl	L179+154
	dl	L179+159
	dl	L179+164
	dl	L179+168
	dl	L179+176
	dl	L179+182
	dl	L179+190
	dl	L179+199
	dl	L179+208
	dl	L179+214
	dl	L179+220
	dl	L179+225
	dl	L179+233
	dl	L179+236
	dl	L179+240
	dl	L179+245
	dl	L179+251
	dl	L179+256
	dl	L179+259
	dl	L179+262
	dl	L179+265
	dl	L179+271
	dl	L179+275
	dl	L179+283
	dl	L179+288
	dl	L179+294
	dl	L179+299
	dl	L179+305
	dl	L179+310
	dl	L179+318
	dl	L179+323
	dl	L179+327
	dl	L179+330
	dl	L179+334
	dl	L179+337
	dl	L179+344
	dl	L179+350
	dl	L179+360
	dl	L179+370
	dl	L179+378
	dl	L179+383
	dl	L179+389
	dl	L179+398
	dl	L179+407
	dl	L179+413
	dl	L179+418
	dl	L179+423
	dl	L179+428
	dl	L179+438
	dl	L179+442
	dl	L179+449
	dl	L179+456
	dl	L179+464
	dl	L179+471
	dl	L179+475
	dl	L179+481
	dl	L179+483
	dl	L179+488
	dl	L179+495
	dl	L179+500
	dl	L179+505
	dl	L179+509
	dl	L179+515
	dl	L179+520
	dl	L179+525
	dl	L179+528
	dl	L179+534
	dl	L179+539
	dl	L179+545
	dl	L179+549
	dl	L179+555
	dl	L179+562
	dl	L179+567
	dl	L179+572
	dl	L179+577
	dl	L179+583
	dl	L179+589
	dl	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dl	$0,$0,$0,$0,$0,$0,$0,$0
	ends
	data
L179:
	db	$41,$4E,$44,$00,$3E,$3E,$00,$44,$49,$56,$00,$45,$4F,$52,$00
	db	$3E,$3D,$00,$3C,$3D,$00,$3C,$3C,$00,$3E,$3E,$3E,$00,$2D,$3D
	db	$00,$4D,$4F,$44,$00,$3C,$3E,$00,$4F,$52,$00,$2B,$3D,$00,$42
	db	$45,$41,$54,$53,$00,$42,$50,$55,$54,$00,$43,$41,$4C,$4C,$00
	db	$43,$41,$53,$45,$00,$43,$41,$53,$45,$00,$43,$48,$41,$49,$4E
	db	$00,$43,$49,$52,$43,$4C,$45,$00,$43,$4C,$47,$00,$43,$4C,$45
	db	$41,$52,$00,$43,$4C,$4F,$53,$45,$00,$43,$4C,$53,$00,$43,$4F
	db	$4C,$4F,$55,$52,$00,$44,$41,$54,$41,$00,$44,$45,$46,$00,$44
	db	$49,$4D,$00,$44,$52,$41,$57,$00,$44,$52,$41,$57,$20,$42,$59
	db	$00,$45,$4C,$4C,$49,$50,$53,$45,$00,$45,$4C,$53,$45,$00,$45
	db	$4C,$53,$45,$00,$45,$4C,$53,$45,$00,$45,$4C,$53,$45,$00,$45
	db	$4E,$44,$00,$45,$4E,$44,$43,$41,$53,$45,$00,$45,$4E,$44,$49
	db	$46,$00,$45,$4E,$44,$50,$52,$4F,$43,$00,$45,$4E,$44,$57,$48
	db	$49,$4C,$45,$00,$45,$4E,$56,$45,$4C,$4F,$50,$45,$00,$45,$52
	db	$52,$4F,$52,$00,$46,$41,$4C,$53,$45,$00,$46,$49,$4C,$4C,$00
	db	$46,$49,$4C,$4C,$20,$42,$59,$00,$46,$4E,$00,$46,$4F,$52,$00
	db	$47,$43,$4F,$4C,$00,$47,$4F,$53,$55,$42,$00,$47,$4F,$54,$4F
	db	$00,$49,$46,$00,$49,$46,$00,$49,$46,$00,$49,$4E,$50,$55,$54
	db	$00,$4C,$45,$54,$00,$4C,$49,$42,$52,$41,$52,$59,$00,$4C,$49
	db	$4E,$45,$00,$4C,$4F,$43,$41,$4C,$00,$4D,$4F,$44,$45,$00,$4D
	db	$4F,$55,$53,$45,$00,$4D,$4F,$56,$45,$00,$4D,$4F,$56,$45,$20
	db	$42,$59,$00,$4E,$45,$58,$54,$00,$4E,$4F,$54,$00,$4F,$46,$00
	db	$4F,$46,$46,$00,$4F,$4E,$00,$4F,$52,$49,$47,$49,$4E,$00,$4F
	db	$53,$43,$4C,$49,$00,$4F,$54,$48,$45,$52,$57,$49,$53,$45,$00
	db	$4F,$54,$48,$45,$52,$57,$49,$53,$45,$00,$4F,$56,$45,$52,$4C
	db	$41,$59,$00,$50,$4C,$4F,$54,$00,$50,$4F,$49,$4E,$54,$00,$50
	db	$4F,$49,$4E,$54,$20,$42,$59,$00,$50,$4F,$49,$4E,$54,$20,$54
	db	$4F,$00,$50,$52,$49,$4E,$54,$00,$50,$52,$4F,$43,$00,$51,$55
	db	$49,$54,$00,$52,$45,$41,$44,$00,$52,$45,$43,$54,$41,$4E,$47
	db	$4C,$45,$00,$52,$45,$4D,$00,$52,$45,$50,$45,$41,$54,$00,$52
	db	$45,$50,$4F,$52,$54,$00,$52,$45,$53,$54,$4F,$52,$45,$00,$52
	db	$45,$54,$55,$52,$4E,$00,$52,$55,$4E,$00,$53,$4F,$55,$4E,$44
	db	$00,$2A,$00,$53,$54,$45,$50,$00,$53,$54,$45,$52,$45,$4F,$00
	db	$53,$54,$4F,$50,$00,$53,$57,$41,$50,$00,$53,$59,$53,$00,$54
	db	$45,$4D,$50,$4F,$00,$54,$48,$45,$4E,$00,$54,$49,$4E,$54,$00
	db	$54,$4F,$00,$54,$52,$41,$43,$45,$00,$54,$52,$55,$45,$00,$55
	db	$4E,$54,$49,$4C,$00,$56,$44,$55,$00,$56,$4F,$49,$43,$45,$00
	db	$56,$4F,$49,$43,$45,$53,$00,$57,$41,$49,$54,$00,$57,$48,$45
	db	$4E,$00,$57,$48,$45,$4E,$00,$57,$48,$49,$4C,$45,$00,$57,$48
	db	$49,$4C,$45,$00,$57,$49,$44,$54,$48,$00
	ends
	data
~~commandlist:
	dl	$0
	dl	L483+0
	dl	L483+7
	dl	L483+12
	dl	L483+19
	dl	L483+26
	dl	L483+31
	dl	L483+37
	dl	L483+42
	dl	L483+50
	dl	L483+55
	dl	L483+61
	dl	L483+68
	dl	L483+74
	dl	L483+80
	dl	L483+86
	dl	L483+91
	dl	L483+96
	dl	L483+100
	dl	L483+104
	dl	L483+113
	dl	L483+118
	dl	L483+124
	dl	L483+133
	dl	L483+142
	dl	L483+152
	dl	L483+157
	ends
	data
L483:
	db	$41,$50,$50,$45,$4E,$44,$00,$41,$55,$54,$4F,$00,$43,$52,$55
	db	$4E,$43,$48,$00,$44,$45,$4C,$45,$54,$45,$00,$45,$44,$49,$54
	db	$00,$45,$44,$49,$54,$4F,$00,$48,$45,$4C,$50,$00,$49,$4E,$53
	db	$54,$41,$4C,$4C,$00,$4C,$49,$53,$54,$00,$4C,$49,$53,$54,$42
	db	$00,$4C,$49,$53,$54,$49,$46,$00,$4C,$49,$53,$54,$4C,$00,$4C
	db	$49,$53,$54,$4F,$00,$4C,$49,$53,$54,$57,$00,$4C,$4F,$41,$44
	db	$00,$4C,$56,$41,$52,$00,$4E,$45,$57,$00,$4F,$4C,$44,$00,$52
	db	$45,$4E,$55,$4D,$42,$45,$52,$00,$53,$41,$56,$45,$00,$53,$41
	db	$56,$45,$4F,$00,$54,$45,$58,$54,$4C,$4F,$41,$44,$00,$54,$45
	db	$58,$54,$53,$41,$56,$45,$00,$54,$45,$58,$54,$53,$41,$56,$45
	db	$4F,$00,$54,$57,$49,$4E,$00,$54,$57,$49,$4E,$4F,$00
	ends
	data
~~functionlist:
	dl	$0
	dl	L484+0
	dl	L484+6
	dl	L484+10
	dl	L484+20
	dl	L484+27
	dl	L484+33
	dl	L484+39
	dl	L484+44
	dl	L484+48
	dl	L484+56
	dl	L484+61
	dl	$0,$0,$0,$0
	dl	L484+67
	dl	L484+71
	dl	L484+75
	dl	L484+81
	dl	L484+86
	dl	L484+92
	dl	L484+96
	dl	L484+100
	dl	L484+104
	dl	L484+109
	dl	L484+114
	dl	L484+119
	dl	L484+123
	dl	L484+129
	dl	L484+133
	dl	L484+137
	dl	L484+141
	dl	L484+145
	dl	L484+150
	dl	L484+154
	dl	L484+158
	dl	L484+163
	dl	L484+169
	dl	L484+176
	dl	L484+183
	dl	L484+187
	dl	L484+191
	dl	L484+197
	dl	L484+200
	dl	L484+204
	dl	L484+211
	dl	L484+219
	dl	L484+226
	dl	L484+229
	dl	L484+236
	dl	L484+240
	dl	L484+244
	dl	L484+252
	dl	L484+260
	dl	L484+264
	dl	L484+268
	dl	L484+272
	dl	L484+276
	dl	L484+281
	dl	L484+290
	dl	L484+294
	dl	L484+298
	dl	L484+304
	dl	L484+308
	dl	L484+312
	dl	L484+316
	dl	L484+324
	dl	L484+329
	ends
	data
L484:
	db	$48,$49,$4D,$45,$4D,$00,$45,$58,$54,$00,$46,$49,$4C,$45,$50
	db	$41,$54,$48,$24,$00,$4C,$45,$46,$54,$24,$28,$00,$4C,$4F,$4D
	db	$45,$4D,$00,$4D,$49,$44,$24,$28,$00,$50,$41,$47,$45,$00,$50
	db	$54,$52,$00,$52,$49,$47,$48,$54,$24,$28,$00,$54,$49,$4D,$45
	db	$00,$54,$49,$4D,$45,$24,$00,$41,$42,$53,$00,$41,$43,$53,$00
	db	$41,$44,$56,$41,$4C,$00,$41,$52,$47,$43,$00,$41,$52,$47,$56
	db	$24,$00,$41,$53,$43,$00,$41,$53,$4E,$00,$41,$54,$4E,$00,$42
	db	$45,$41,$54,$00,$42,$47,$45,$54,$00,$43,$48,$52,$24,$00,$43
	db	$4F,$53,$00,$43,$4F,$55,$4E,$54,$00,$44,$45,$47,$00,$45,$4F
	db	$46,$00,$45,$52,$4C,$00,$45,$52,$52,$00,$45,$56,$41,$4C,$00
	db	$45,$58,$50,$00,$47,$45,$54,$00,$47,$45,$54,$24,$00,$49,$4E
	db	$4B,$45,$59,$00,$49,$4E,$4B,$45,$59,$24,$00,$49,$4E,$53,$54
	db	$52,$28,$00,$49,$4E,$54,$00,$4C,$45,$4E,$00,$4C,$49,$53,$54
	db	$4F,$00,$4C,$4E,$00,$4C,$4F,$47,$00,$4F,$50,$45,$4E,$49,$4E
	db	$00,$4F,$50,$45,$4E,$4F,$55,$54,$00,$4F,$50,$45,$4E,$55,$50
	db	$00,$50,$49,$00,$50,$4F,$49,$4E,$54,$28,$00,$50,$4F,$53,$00
	db	$52,$41,$44,$00,$52,$45,$50,$4F,$52,$54,$24,$00,$52,$45,$54
	db	$43,$4F,$44,$45,$00,$52,$4E,$44,$00,$53,$47,$4E,$00,$53,$49
	db	$4E,$00,$53,$51,$52,$00,$53,$54,$52,$24,$00,$53,$54,$52,$49
	db	$4E,$47,$24,$28,$00,$53,$55,$4D,$00,$54,$41,$4E,$00,$54,$45
	db	$4D,$50,$4F,$00,$54,$4F,$50,$00,$55,$53,$52,$00,$56,$41,$4C
	db	$00,$56,$45,$52,$49,$46,$59,$28,$00,$56,$50,$4F,$53,$00,$58
	db	$4C,$41,$54,$45,$24,$28,$00
	ends
	data
~~printlist:
	dl	$0
	dl	L485+0
	dl	L485+4
	ends
	data
L485:
	db	$53,$50,$43,$00,$54,$41,$42,$28,$00
	ends
	code
	func
~~expand_token:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L487
	tcs
	phd
	tcd
cp_0	set	4
namelist_0	set	8
token_0	set	12
n_1	set	0
count_1	set	2
name_1	set	4
	lda	<L487+token_0
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L487+namelist_0
	adc	<R0
	sta	<R2
	lda	<L487+namelist_0+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L488+name_1
	ldy	#$2
	lda	[<R2],Y
	sta	<L488+name_1+2
	lda	<L488+name_1
	ora	<L488+name_1+2
	beq	L489
	brl	L10293
L489:
	pea	#^L486
	pea	#<L486
	pea	#<$605
	pea	#<$82
	pea	#10
	jsl	~~error
L10293:
	pei	<L488+name_1+2
	pei	<L488+name_1
	pei	<L487+cp_0+2
	pei	<L487+cp_0
	jsl	~~strcpy
	pei	<L488+name_1+2
	pei	<L488+name_1
	jsl	~~strlen
	sta	<L488+count_1
	lda	|~~basicvars+429
	bit	#$10
	bne	L490
	brl	L10294
L490:
	stz	<L488+n_1
	brl	L10298
L10297:
	lda	[<L487+cp_0]
	and	#$ff
	pha
	jsl	~~tolower
	sep	#$20
	longa	off
	sta	[<L487+cp_0]
	rep	#$20
	longa	on
	inc	<L487+cp_0
	bne	L491
	inc	<L487+cp_0+2
L491:
L10295:
	inc	<L488+n_1
L10298:
	sec
	lda	<L488+n_1
	sbc	<L488+count_1
	bvs	L492
	eor	#$8000
L492:
	bmi	L493
	brl	L10297
L493:
L10296:
L10294:
	lda	<L488+count_1
L494:
	tay
	lda	<L487+2
	sta	<L487+2+10
	lda	<L487+1
	sta	<L487+1+10
	pld
	tsc
	clc
	adc	#L487+10
	tcs
	tya
	rtl
L487	equ	20
L488	equ	13
	ends
	efunc
	data
L486:
	db	$74,$6F,$6B,$65,$6E,$73,$00
	ends
	code
	func
~~skip_source:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L496
	tcs
	phd
	tcd
p_0	set	4
token_1	set	0
	sep	#$20
	longa	off
	lda	[<L496+p_0]
	sta	<L497+token_1
	rep	#$20
	longa	on
	lda	<L497+token_1
	and	#$ff
	beq	L498
	brl	L10299
L498:
	ldx	<L496+p_0+2
	lda	<L496+p_0
L499:
	tay
	lda	<L496+2
	sta	<L496+2+4
	lda	<L496+1
	sta	<L496+1+4
	pld
	tsc
	clc
	adc	#L496+4
	tcs
	tya
	rtl
L10299:
	sep	#$20
	longa	off
	lda	<L497+token_1
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L500
	brl	L10300
L500:
	clc
	lda	#$3
	adc	<L496+p_0
	sta	<R0
	lda	#$0
	adc	<L496+p_0+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L499
L10300:
	sep	#$20
	longa	off
	lda	<L497+token_1
	cmp	#<$fc
	rep	#$20
	longa	on
	bcs	L501
	brl	L10301
L501:
	clc
	lda	#$2
	adc	<L496+p_0
	sta	<R0
	lda	#$0
	adc	<L496+p_0+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L499
L10301:
	clc
	lda	#$1
	adc	<L496+p_0
	sta	<R0
	lda	#$0
	adc	<L496+p_0+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L499
L496	equ	5
L497	equ	5
	ends
	efunc
	code
	xdef	~~expand
	func
~~expand:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L502
	tcs
	phd
	tcd
line_0	set	4
text_0	set	8
token_1	set	0
lp_1	set	1
n_1	set	5
count_1	set	7
thisindent_1	set	9
nextindent_1	set	11
	lda	|~~basicvars+429
	bit	#$8
	beq	L504
	brl	L10302
L504:
	pei	<L502+line_0+2
	pei	<L502+line_0
	jsl	~~get_lineno
	pha
	pea	#^L495
	pea	#<L495
	pei	<L502+text_0+2
	pei	<L502+text_0
	pea	#12
	jsl	~~sprintf
	clc
	lda	#$5
	adc	<L502+text_0
	sta	<L502+text_0
	bcc	L505
	inc	<L502+text_0+2
L505:
	lda	|~~basicvars+429
	bit	#$1
	bne	L506
	brl	L10303
L506:
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L502+text_0]
	rep	#$20
	longa	on
	inc	<L502+text_0
	bne	L507
	inc	<L502+text_0+2
L507:
L10303:
L10302:
	clc
	lda	#$6
	adc	<L502+line_0
	sta	<L503+lp_1
	lda	#$0
	adc	<L502+line_0+2
	sta	<L503+lp_1+2
	lda	|~~basicvars+429
	bit	#$2
	bne	L508
	brl	L10304
L508:
	pei	<L503+lp_1+2
	pei	<L503+lp_1
	jsl	~~skip
	sta	<L503+lp_1
	stx	<L503+lp_1+2
	lda	|~~indentation
	sta	<L503+nextindent_1
	lda	<L503+nextindent_1
	sta	<L503+thisindent_1
	lda	[<L503+lp_1]
	and	#$ff
	brl	L10305
L10307:
	stz	<L503+nextindent_1
	stz	<L503+thisindent_1
	brl	L10306
L10308:
L10309:
L10310:
L10311:
L10312:
L10313:
	dec	<L503+thisindent_1
	dec	<L503+thisindent_1
	lda	<L503+thisindent_1
	bmi	L509
	brl	L10314
L509:
	stz	<L503+thisindent_1
L10314:
	clc
	lda	#$2
	adc	<L503+thisindent_1
	sta	<L503+nextindent_1
	brl	L10306
L10315:
L10316:
	dec	<L503+thisindent_1
	dec	<L503+thisindent_1
	dec	<L503+nextindent_1
	dec	<L503+nextindent_1
	brl	L10306
L10305:
	xref	~~~swt
	jsl	~~~swt
	dw	9
	dw	154
	dw	L10307-1
	dw	161
	dw	L10309-1
	dw	162
	dw	L10308-1
	dw	164
	dw	L10316-1
	dw	165
	dw	L10315-1
	dw	197
	dw	L10313-1
	dw	198
	dw	L10312-1
	dw	233
	dw	L10311-1
	dw	234
	dw	L10310-1
	dw	L10306-1
L10306:
L10317:
	lda	[<L503+lp_1]
	and	#$ff
	bne	L510
	brl	L10318
L510:
	lda	[<L503+lp_1]
	and	#$ff
	brl	L10319
L10321:
L10322:
L10323:
L10324:
L10325:
L10326:
	inc	<L503+nextindent_1
	inc	<L503+nextindent_1
	brl	L10320
L10327:
	ldy	#$1
	lda	[<L503+lp_1],Y
	and	#$ff
	beq	L511
	brl	L10328
L511:
	inc	<L503+nextindent_1
	inc	<L503+nextindent_1
L10328:
	brl	L10320
L10329:
L10330:
	lda	<L503+nextindent_1
	cmp	<L503+thisindent_1
	beq	L512
	brl	L10331
L512:
	dec	<L503+thisindent_1
	dec	<L503+thisindent_1
L10331:
	dec	<L503+nextindent_1
	dec	<L503+nextindent_1
	brl	L10320
L10332:
	lda	<L503+nextindent_1
	cmp	<L503+thisindent_1
	beq	L513
	brl	L10333
L513:
	dec	<L503+thisindent_1
	dec	<L503+thisindent_1
L10333:
	dec	<L503+nextindent_1
	dec	<L503+nextindent_1
	pei	<L503+lp_1+2
	pei	<L503+lp_1
	jsl	~~skip_source
	sta	<L503+lp_1
	stx	<L503+lp_1+2
L10334:
	lda	[<L503+lp_1]
	and	#$ff
	bne	L514
	brl	L10335
L514:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L515
	brl	L10335
L515:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	cmp	#<$9f
	rep	#$20
	longa	on
	bne	L516
	brl	L10335
L516:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	cmp	#<$a0
	rep	#$20
	longa	on
	bne	L517
	brl	L10335
L517:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L518
	brl	L10336
L518:
	dec	<L503+nextindent_1
	dec	<L503+nextindent_1
L10336:
	pei	<L503+lp_1+2
	pei	<L503+lp_1
	jsl	~~skip_source
	sta	<L503+lp_1
	stx	<L503+lp_1+2
	brl	L10334
L10335:
	brl	L10320
L10319:
	xref	~~~swt
	jsl	~~~swt
	dw	10
	dw	144
	dw	L10326-1
	dw	145
	dw	L10325-1
	dw	167
	dw	L10329-1
	dw	174
	dw	L10324-1
	dw	190
	dw	L10332-1
	dw	210
	dw	L10323-1
	dw	223
	dw	L10327-1
	dw	228
	dw	L10330-1
	dw	235
	dw	L10322-1
	dw	236
	dw	L10321-1
	dw	L10320-1
L10320:
	pei	<L503+lp_1+2
	pei	<L503+lp_1
	jsl	~~skip_source
	sta	<L503+lp_1
	stx	<L503+lp_1+2
	brl	L10317
L10318:
	lda	<L503+thisindent_1
	bmi	L519
	brl	L10337
L519:
	stz	<L503+thisindent_1
L10337:
	lda	<L503+nextindent_1
	bmi	L520
	brl	L10338
L520:
	stz	<L503+nextindent_1
L10338:
	lda	#$1
	sta	<L503+n_1
	brl	L10342
L10341:
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L502+text_0]
	rep	#$20
	longa	on
	inc	<L502+text_0
	bne	L521
	inc	<L502+text_0+2
L521:
L10339:
	inc	<L503+n_1
L10342:
	sec
	lda	<L503+thisindent_1
	sbc	<L503+n_1
	bvs	L522
	eor	#$8000
L522:
	bpl	L523
	brl	L10341
L523:
L10340:
	lda	<L503+nextindent_1
	sta	|~~indentation
	clc
	lda	#$6
	adc	<L502+line_0
	sta	<R0
	lda	#$0
	adc	<L502+line_0+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~skip
	sta	<L503+lp_1
	stx	<L503+lp_1+2
L10304:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	<L503+token_1
	rep	#$20
	longa	on
L10343:
	lda	<L503+token_1
	and	#$ff
	bne	L524
	brl	L10344
L524:
	sep	#$20
	longa	off
	lda	<L503+token_1
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L525
	brl	L10345
L525:
	inc	<L503+lp_1
	bne	L526
	inc	<L503+lp_1+2
L526:
	pei	<L503+lp_1+2
	pei	<L503+lp_1
	jsl	~~get_lineno
	pha
	pea	#^L495+4
	pea	#<L495+4
	pei	<L502+text_0+2
	pei	<L502+text_0
	pea	#12
	jsl	~~sprintf
	sta	<L503+count_1
	ldy	#$0
	lda	<L503+count_1
	bpl	L527
	dey
L527:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L502+text_0
	adc	<R0
	sta	<L502+text_0
	lda	<L502+text_0+2
	adc	<R0+2
	sta	<L502+text_0+2
	clc
	lda	#$2
	adc	<L503+lp_1
	sta	<L503+lp_1
	bcc	L528
	inc	<L503+lp_1+2
L528:
	brl	L10346
L10345:
	sep	#$20
	longa	off
	lda	<L503+token_1
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L529
	brl	L10347
L529:
	inc	<L503+lp_1
	bne	L530
	inc	<L503+lp_1+2
L530:
	brl	L10348
L10347:
	sep	#$20
	longa	off
	lda	<L503+token_1
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L531
	brl	L10349
L531:
L10352:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	[<L502+text_0]
	rep	#$20
	longa	on
	inc	<L502+text_0
	bne	L532
	inc	<L502+text_0+2
L532:
	inc	<L503+lp_1
	bne	L533
	inc	<L503+lp_1+2
L533:
L10350:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	cmp	#<$22
	rep	#$20
	longa	on
	bne	L535
	brl	L534
L535:
	lda	[<L503+lp_1]
	and	#$ff
	beq	L536
	brl	L10352
L536:
L534:
L10351:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L537
	brl	L10353
L537:
	sep	#$20
	longa	off
	lda	#$22
	sta	[<L502+text_0]
	rep	#$20
	longa	on
	inc	<L502+text_0
	bne	L538
	inc	<L502+text_0+2
L538:
	inc	<L503+lp_1
	bne	L539
	inc	<L503+lp_1+2
L539:
L10353:
	brl	L10354
L10349:
	sep	#$20
	longa	off
	lda	<L503+token_1
	cmp	#<$80
	rep	#$20
	longa	on
	bcc	L540
	brl	L10355
L540:
	sep	#$20
	longa	off
	lda	<L503+token_1
	sta	[<L502+text_0]
	rep	#$20
	longa	on
	inc	<L502+text_0
	bne	L541
	inc	<L502+text_0+2
L541:
	inc	<L503+lp_1
	bne	L542
	inc	<L503+lp_1+2
L542:
	brl	L10356
L10355:
	sep	#$20
	longa	off
	lda	<L503+token_1
	cmp	#<$99
	rep	#$20
	longa	on
	bne	L544
	brl	L543
L544:
	sep	#$20
	longa	off
	lda	<L503+token_1
	cmp	#<$d1
	rep	#$20
	longa	on
	beq	L545
	brl	L10357
L545:
L543:
	lda	<L503+token_1
	and	#$ff
	sta	<R0
	clc
	lda	#$ff80
	adc	<R0
	pha
	lda	#<~~onebytelist
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L502+text_0+2
	pei	<L502+text_0
	jsl	~~expand_token
	sta	<L503+count_1
	ldy	#$0
	lda	<L503+count_1
	bpl	L546
	dey
L546:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L502+text_0
	adc	<R0
	sta	<L502+text_0
	lda	<L502+text_0+2
	adc	<R0+2
	sta	<L502+text_0+2
	inc	<L503+lp_1
	bne	L547
	inc	<L503+lp_1+2
L547:
L10358:
	lda	[<L503+lp_1]
	and	#$ff
	bne	L548
	brl	L10359
L548:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	[<L502+text_0]
	rep	#$20
	longa	on
	inc	<L502+text_0
	bne	L549
	inc	<L502+text_0+2
L549:
	inc	<L503+lp_1
	bne	L550
	inc	<L503+lp_1+2
L550:
	brl	L10358
L10359:
	brl	L10360
L10357:
	lda	<L503+token_1
	and	#$ff
	brl	L10361
L10363:
	inc	<L503+lp_1
	bne	L551
	inc	<L503+lp_1+2
L551:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	<L503+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$2
	cmp	<L503+token_1
	rep	#$20
	longa	on
	bcc	L552
	brl	L10364
L552:
	pea	#<$7
	pea	#4
	jsl	~~error
L10364:
	pei	<L503+token_1
	lda	#<~~printlist
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L502+text_0+2
	pei	<L502+text_0
	jsl	~~expand_token
	sta	<L503+count_1
	brl	L10362
L10365:
	inc	<L503+lp_1
	bne	L553
	inc	<L503+lp_1+2
L553:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	<L503+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$43
	cmp	<L503+token_1
	rep	#$20
	longa	on
	bcc	L554
	brl	L10366
L554:
	pea	#<$7
	pea	#4
	jsl	~~error
L10366:
	pei	<L503+token_1
	lda	#<~~functionlist
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L502+text_0+2
	pei	<L502+text_0
	jsl	~~expand_token
	sta	<L503+count_1
	brl	L10362
L10367:
	inc	<L503+lp_1
	bne	L555
	inc	<L503+lp_1+2
L555:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	<L503+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1a
	cmp	<L503+token_1
	rep	#$20
	longa	on
	bcc	L556
	brl	L10368
L556:
	pea	#<$7
	pea	#4
	jsl	~~error
L10368:
	pei	<L503+token_1
	lda	#<~~commandlist
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L502+text_0+2
	pei	<L502+text_0
	jsl	~~expand_token
	sta	<L503+count_1
	brl	L10362
L10369:
	lda	<L503+token_1
	and	#$ff
	sta	<R0
	clc
	lda	#$ff80
	adc	<R0
	pha
	lda	#<~~onebytelist
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L502+text_0+2
	pei	<L502+text_0
	jsl	~~expand_token
	sta	<L503+count_1
	brl	L10362
L10361:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	252
	dw	L10367-1
	dw	254
	dw	L10363-1
	dw	255
	dw	L10365-1
	dw	L10369-1
L10362:
	ldy	#$0
	lda	<L503+count_1
	bpl	L557
	dey
L557:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L502+text_0
	adc	<R0
	sta	<L502+text_0
	lda	<L502+text_0+2
	adc	<R0+2
	sta	<L502+text_0+2
	inc	<L503+lp_1
	bne	L558
	inc	<L503+lp_1+2
L558:
L10360:
L10356:
L10354:
L10348:
L10346:
	sep	#$20
	longa	off
	lda	[<L503+lp_1]
	sta	<L503+token_1
	rep	#$20
	longa	on
	brl	L10343
L10344:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L502+text_0]
	rep	#$20
	longa	on
L559:
	lda	<L502+2
	sta	<L502+2+8
	lda	<L502+1
	sta	<L502+1+8
	pld
	tsc
	clc
	adc	#L502+8
	tcs
	rtl
L502	equ	17
L503	equ	5
	ends
	efunc
	data
L495:
	db	$25,$35,$64,$00,$25,$64,$00
	ends
	code
	xdef	~~reset_indent
	func
~~reset_indent:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L561
	tcs
	phd
	tcd
	stz	|~~indentation
L563:
	pld
	tsc
	clc
	adc	#L561
	tcs
	rtl
L561	equ	0
L562	equ	1
	ends
	efunc
	code
	xdef	~~set_dest
	func
~~set_dest:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L564
	tcs
	phd
	tcd
tp_0	set	4
dest_0	set	8
offset_1	set	0
	sec
	lda	<L564+dest_0
	sbc	<L564+tp_0
	sta	<R0
	lda	<L564+dest_0+2
	sbc	<L564+tp_0+2
	sta	<R0+2
	lda	<R0
	sta	<L565+offset_1
	sep	#$20
	longa	off
	lda	<L565+offset_1
	sta	[<L564+tp_0]
	rep	#$20
	longa	on
	lda	<L565+offset_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$1
	sta	[<L564+tp_0],Y
	rep	#$20
	longa	on
	lda	#$20
	tsb	~~basicvars+423
L566:
	lda	<L564+2
	sta	<L564+2+8
	lda	<L564+1
	sta	<L564+1+8
	pld
	tsc
	clc
	adc	#L564+8
	tcs
	rtl
L564	equ	6
L565	equ	5
	ends
	efunc
	code
	xdef	~~set_address
	func
~~set_address:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L567
	tcs
	phd
	tcd
tp_0	set	4
p_0	set	8
n_1	set	0
offset_1	set	2
	lda	#$20
	tsb	~~basicvars+423
	sec
	lda	<L567+p_0
	sbc	|~~basicvars
	sta	<R0
	lda	<L567+p_0+2
	sbc	|~~basicvars+2
	sta	<R0+2
	lda	<R0
	sta	<L568+offset_1
	stz	<L568+n_1
L10372:
	inc	<L567+tp_0
	bne	L569
	inc	<L567+tp_0+2
L569:
	sep	#$20
	longa	off
	lda	<L568+offset_1
	sta	[<L567+tp_0]
	rep	#$20
	longa	on
	lda	<L568+offset_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sta	<L568+offset_1
L10370:
	inc	<L568+n_1
	lda	<L568+n_1
	bmi	L570
	dea
	dea
	dea
	dea
	bpl	L571
L570:
	brl	L10372
L571:
L10371:
L572:
	lda	<L567+2
	sta	<L567+2+8
	lda	<L567+1
	sta	<L567+1+8
	pld
	tsc
	clc
	adc	#L567+8
	tcs
	rtl
L567	equ	8
L568	equ	5
	ends
	efunc
	code
	xdef	~~get_srcaddr
	func
~~get_srcaddr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L573
	tcs
	phd
	tcd
p_0	set	4
	ldy	#$2
	lda	[<L573+p_0],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$1
	lda	[<L573+p_0],Y
	and	#$ff
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L575
	dey
L575:
	sta	<R0
	sty	<R0+2
	sec
	lda	<L573+p_0
	sbc	<R0
	sta	<R1
	lda	<L573+p_0+2
	sbc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L576:
	tay
	lda	<L573+2
	sta	<L573+2+4
	lda	<L573+1
	sta	<L573+1+4
	pld
	tsc
	clc
	adc	#L573+4
	tcs
	tya
	rtl
L573	equ	12
L574	equ	13
	ends
	efunc
	code
	func
~~clear_varaddrs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L577
	tcs
	phd
	tcd
bp_0	set	4
sp_1	set	0
tp_1	set	4
offset_1	set	8
	clc
	lda	#$6
	adc	<L577+bp_0
	sta	<L578+sp_1
	lda	#$0
	adc	<L577+bp_0+2
	sta	<L578+sp_1+2
	ldy	#$5
	lda	[<L577+bp_0],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L579
	dey
L579:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L577+bp_0],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L577+bp_0
	adc	<R2
	sta	<L578+tp_1
	lda	<L577+bp_0+2
	adc	<R2+2
	sta	<L578+tp_1+2
L10373:
	lda	[<L578+tp_1]
	and	#$ff
	bne	L580
	brl	L10374
L580:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L582
	brl	L581
L582:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$3
	rep	#$20
	longa	on
	bcs	L583
	brl	L10375
L583:
	sep	#$20
	longa	off
	lda	#$a
	cmp	[<L578+tp_1]
	rep	#$20
	longa	on
	bcs	L584
	brl	L10375
L584:
L581:
L10376:
	sep	#$20
	longa	off
	lda	[<L578+sp_1]
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L585
	brl	L10377
L585:
	lda	[<L578+sp_1]
	and	#$ff
	bne	L586
	brl	L10377
L586:
	pei	<L578+sp_1+2
	pei	<L578+sp_1
	jsl	~~skip_source
	sta	<L578+sp_1
	stx	<L578+sp_1+2
	brl	L10376
L10377:
	lda	[<L578+sp_1]
	and	#$ff
	beq	L587
	brl	L10378
L587:
	pea	#^L560
	pea	#<L560
	pea	#<$6e5
	pea	#<$82
	pea	#10
	jsl	~~error
L10378:
	inc	<L578+sp_1
	bne	L588
	inc	<L578+sp_1+2
L588:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L589
	brl	L10379
L589:
	sep	#$20
	longa	off
	lda	#$1
	sta	[<L578+tp_1]
	rep	#$20
	longa	on
	sec
	lda	<L578+tp_1
	sbc	<L578+sp_1
	sta	<R0
	lda	<L578+tp_1+2
	sbc	<L578+sp_1+2
	sta	<R0+2
	lda	<R0
	sta	<L578+offset_1
	sep	#$20
	longa	off
	lda	<L578+offset_1
	ldy	#$1
	sta	[<L578+tp_1],Y
	rep	#$20
	longa	on
	lda	<L578+offset_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$2
	sta	[<L578+tp_1],Y
	rep	#$20
	longa	on
L10379:
	brl	L10380
L10375:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L591
	brl	L590
L591:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$c
	rep	#$20
	longa	on
	beq	L592
	brl	L10381
L592:
L590:
L10382:
	sep	#$20
	longa	off
	lda	[<L578+sp_1]
	cmp	#<$cd
	rep	#$20
	longa	on
	bne	L593
	brl	L10383
L593:
	sep	#$20
	longa	off
	lda	[<L578+sp_1]
	cmp	#<$ad
	rep	#$20
	longa	on
	bne	L594
	brl	L10383
L594:
	lda	[<L578+sp_1]
	and	#$ff
	bne	L595
	brl	L10383
L595:
	inc	<L578+sp_1
	bne	L596
	inc	<L578+sp_1+2
L596:
	brl	L10382
L10383:
	lda	[<L578+sp_1]
	and	#$ff
	beq	L597
	brl	L10384
L597:
	pea	#^L560+7
	pea	#<L560+7
	pea	#<$6f0
	pea	#<$82
	pea	#10
	jsl	~~error
L10384:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L598
	brl	L10385
L598:
	sep	#$20
	longa	off
	lda	#$c
	sta	[<L578+tp_1]
	rep	#$20
	longa	on
	sec
	lda	<L578+tp_1
	sbc	<L578+sp_1
	sta	<R0
	lda	<L578+tp_1+2
	sbc	<L578+sp_1+2
	sta	<R0+2
	lda	<R0
	sta	<L578+offset_1
	sep	#$20
	longa	off
	lda	<L578+offset_1
	ldy	#$1
	sta	[<L578+tp_1],Y
	rep	#$20
	longa	on
	lda	<L578+offset_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$2
	sta	[<L578+tp_1],Y
	rep	#$20
	longa	on
L10385:
	inc	<L578+sp_1
	bne	L599
	inc	<L578+sp_1+2
L599:
	brl	L10386
L10381:
	sep	#$20
	longa	off
	lda	[<L578+tp_1]
	cmp	#<$91
	rep	#$20
	longa	on
	beq	L600
	brl	L10387
L600:
	sep	#$20
	longa	off
	lda	#$90
	sta	[<L578+tp_1]
	rep	#$20
	longa	on
L10387:
L10386:
L10380:
	pei	<L578+tp_1+2
	pei	<L578+tp_1
	jsl	~~skip_token
	sta	<L578+tp_1
	stx	<L578+tp_1+2
	brl	L10373
L10374:
L601:
	lda	<L577+2
	sta	<L577+2+4
	lda	<L577+1
	sta	<L577+1+4
	pld
	tsc
	clc
	adc	#L577+4
	tcs
	rtl
L577	equ	22
L578	equ	13
	ends
	efunc
	data
L560:
	db	$74,$6F,$6B,$65,$6E,$73,$00,$74,$6F,$6B,$65,$6E,$73,$00
	ends
	code
	xdef	~~clear_branches
	func
~~clear_branches:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L603
	tcs
	phd
	tcd
bp_0	set	4
tp_1	set	0
lp_1	set	4
line_1	set	8
	ldy	#$5
	lda	[<L603+bp_0],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L605
	dey
L605:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L603+bp_0],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L603+bp_0
	adc	<R2
	sta	<L604+tp_1
	lda	<L603+bp_0+2
	adc	<R2+2
	sta	<L604+tp_1+2
L10388:
	lda	[<L604+tp_1]
	and	#$ff
	bne	L606
	brl	L10389
L606:
	lda	[<L604+tp_1]
	and	#$ff
	brl	L10390
L10392:
	sep	#$20
	longa	off
	lda	#$1e
	sta	[<L604+tp_1]
	rep	#$20
	longa	on
	pei	<L604+tp_1+2
	pei	<L604+tp_1
	jsl	~~get_address
	sta	<L604+lp_1
	stx	<L604+lp_1+2
	pei	<L604+lp_1+2
	pei	<L604+lp_1
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~get_lineno
	sta	<L604+line_1
	sep	#$20
	longa	off
	lda	<L604+line_1
	ldy	#$1
	sta	[<L604+tp_1],Y
	rep	#$20
	longa	on
	lda	<L604+line_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	#$2
	sta	[<L604+tp_1],Y
	rep	#$20
	longa	on
	brl	L10391
L10393:
L10394:
	sep	#$20
	longa	off
	lda	#$b2
	sta	[<L604+tp_1]
	rep	#$20
	longa	on
	brl	L10391
L10395:
L10396:
L10397:
L10398:
L10399:
	sep	#$20
	longa	off
	clc
	lda	#$ff
	adc	[<L604+tp_1]
	sta	[<L604+tp_1]
	rep	#$20
	longa	on
	brl	L10391
L10390:
	xref	~~~swt
	jsl	~~~swt
	dw	8
	dw	31
	dw	L10392-1
	dw	160
	dw	L10395-1
	dw	162
	dw	L10396-1
	dw	179
	dw	L10393-1
	dw	180
	dw	L10394-1
	dw	198
	dw	L10398-1
	dw	234
	dw	L10397-1
	dw	236
	dw	L10399-1
	dw	L10391-1
L10391:
	pei	<L604+tp_1+2
	pei	<L604+tp_1
	jsl	~~skip_token
	sta	<L604+tp_1
	stx	<L604+tp_1+2
	brl	L10388
L10389:
L607:
	lda	<L603+2
	sta	<L603+2+4
	lda	<L603+1
	sta	<L603+1+4
	pld
	tsc
	clc
	adc	#L603+4
	tcs
	rtl
L603	equ	22
L604	equ	13
	ends
	efunc
	code
	xdef	~~clear_linerefs
	func
~~clear_linerefs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L608
	tcs
	phd
	tcd
bp_0	set	4
	pei	<L608+bp_0+2
	pei	<L608+bp_0
	jsl	~~clear_branches
	pei	<L608+bp_0+2
	pei	<L608+bp_0
	jsl	~~clear_varaddrs
L610:
	lda	<L608+2
	sta	<L608+2+4
	lda	<L608+1
	sta	<L608+1+4
	pld
	tsc
	clc
	adc	#L608+4
	tcs
	rtl
L608	equ	0
L609	equ	1
	ends
	efunc
	code
	xdef	~~clear_varptrs
	func
~~clear_varptrs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L611
	tcs
	phd
	tcd
bp_1	set	0
lp_1	set	4
	lda	|~~basicvars+22
	sta	<L612+bp_1
	lda	|~~basicvars+22+2
	sta	<L612+bp_1+2
L10400:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L612+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L613
	brl	L10401
L613:
	pei	<L612+bp_1+2
	pei	<L612+bp_1
	jsl	~~clear_varaddrs
	ldy	#$2
	lda	[<L612+bp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L612+bp_1],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L614
	dey
L614:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L612+bp_1
	adc	<R0
	sta	<L612+bp_1
	lda	<L612+bp_1+2
	adc	<R0+2
	sta	<L612+bp_1+2
	brl	L10400
L10401:
	lda	|~~basicvars+415
	sta	<L612+lp_1
	lda	|~~basicvars+415+2
	sta	<L612+lp_1+2
L10402:
	lda	<L612+lp_1
	ora	<L612+lp_1+2
	bne	L615
	brl	L10403
L615:
	ldy	#$8
	lda	[<L612+lp_1],Y
	sta	<L612+bp_1
	ldy	#$a
	lda	[<L612+lp_1],Y
	sta	<L612+bp_1+2
L10404:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L612+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L616
	brl	L10405
L616:
	pei	<L612+bp_1+2
	pei	<L612+bp_1
	jsl	~~clear_varaddrs
	ldy	#$2
	lda	[<L612+bp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L612+bp_1],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L617
	dey
L617:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L612+bp_1
	adc	<R0
	sta	<L612+bp_1
	lda	<L612+bp_1+2
	adc	<R0+2
	sta	<L612+bp_1+2
	brl	L10404
L10405:
	lda	[<L612+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L612+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L612+lp_1
	lda	<R0+2
	sta	<L612+lp_1+2
	brl	L10402
L10403:
L618:
	pld
	tsc
	clc
	adc	#L611
	tcs
	rtl
L611	equ	20
L612	equ	13
	ends
	efunc
	data
~~legalow:
	db	$0,$1,$1,$1,$1,$1,$1,$1,$1,$1
	db	$1,$1,$1,$1,$0,$0,$1,$1,$1,$1
	db	$1,$1,$1,$1,$1,$0,$0,$0,$0,$0
	db	$1,$1
	ends
	code
	xdef	~~isvalid
	func
~~isvalid:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L619
	tcs
	phd
	tcd
bp_0	set	4
length_1	set	0
execoff_1	set	2
base_1	set	4
cp_1	set	8
token_1	set	12
	pei	<L619+bp_0+2
	pei	<L619+bp_0
	jsl	~~get_lineno
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L621
	dey
L621:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L622
	eor	#$8000
L622:
	bpl	L623
	brl	L10406
L623:
	lda	#$0
L624:
	tay
	lda	<L619+2
	sta	<L619+2+4
	lda	<L619+1
	sta	<L619+1+4
	pld
	tsc
	clc
	adc	#L619+4
	tcs
	tya
	rtl
L10406:
	pei	<L619+bp_0+2
	pei	<L619+bp_0
	jsl	~~get_linelen
	sta	<L620+length_1
	sec
	lda	<L620+length_1
	sbc	#<$7
	bvs	L626
	eor	#$8000
L626:
	bmi	L627
	brl	L625
L627:
	sec
	lda	#$400
	sbc	<L620+length_1
	bvs	L628
	eor	#$8000
L628:
	bpl	L629
	brl	L10407
L629:
L625:
	lda	#$0
	brl	L624
L10407:
	pei	<L619+bp_0+2
	pei	<L619+bp_0
	jsl	~~get_exec
	sta	<L620+execoff_1
	lda	<L620+execoff_1
	cmp	#<$6
	bcs	L631
	brl	L630
L631:
	sec
	lda	<L620+length_1
	sbc	<L620+execoff_1
	bvs	L632
	eor	#$8000
L632:
	bpl	L633
	brl	L10408
L633:
L630:
	lda	#$0
	brl	L624
L10408:
	ldy	#$0
	lda	<L620+execoff_1
	bpl	L634
	dey
L634:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L619+bp_0
	adc	<R0
	sta	<L620+cp_1
	lda	<L619+bp_0+2
	adc	<R0+2
	sta	<L620+cp_1+2
	lda	<L620+cp_1
	sta	<L620+base_1
	lda	<L620+cp_1+2
	sta	<L620+base_1+2
L10409:
	ldy	#$0
	lda	<L620+length_1
	bpl	L635
	dey
L635:
	sta	<R0
	sty	<R0+2
	sec
	lda	<L620+cp_1
	sbc	<L620+base_1
	sta	<R1
	lda	<L620+cp_1+2
	sbc	<L620+base_1+2
	sta	<R1+2
	sec
	lda	<R0
	sbc	<R1
	lda	<R0+2
	sbc	<R1+2
	bvs	L636
	eor	#$8000
L636:
	bmi	L637
	brl	L10410
L637:
	lda	[<L620+cp_1]
	and	#$ff
	bne	L638
	brl	L10410
L638:
	sep	#$20
	longa	off
	lda	[<L620+cp_1]
	sta	<L620+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1f
	cmp	<L620+token_1
	rep	#$20
	longa	on
	bcs	L639
	brl	L10411
L639:
	lda	<L620+token_1
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~legalow,X
	and	#$ff
	beq	L640
	brl	L10412
L640:
	lda	#$0
	brl	L624
L10412:
	brl	L10413
L10411:
	sep	#$20
	longa	off
	lda	<L620+token_1
	cmp	#<$80
	rep	#$20
	longa	on
	bcs	L641
	brl	L10414
L641:
	lda	<L620+token_1
	and	#$ff
	brl	L10415
L10417:
	ldy	#$1
	lda	[<L620+cp_1],Y
	and	#$ff
	bne	L643
	brl	L642
L643:
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$1
	cmp	[<L620+cp_1],Y
	rep	#$20
	longa	on
	bcc	L644
	brl	L10418
L644:
L642:
	lda	#$0
	brl	L624
L10418:
	brl	L10416
L10419:
	ldy	#$1
	lda	[<L620+cp_1],Y
	and	#$ff
	bne	L646
	brl	L645
L646:
	sep	#$20
	longa	off
	lda	#$b
	ldy	#$1
	cmp	[<L620+cp_1],Y
	rep	#$20
	longa	on
	bcc	L648
	brl	L647
L648:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L620+cp_1],Y
	cmp	#<$10
	rep	#$20
	longa	on
	bcs	L649
	brl	L645
L649:
L647:
	sep	#$20
	longa	off
	lda	#$42
	ldy	#$1
	cmp	[<L620+cp_1],Y
	rep	#$20
	longa	on
	bcc	L650
	brl	L10420
L650:
L645:
	lda	#$0
	brl	L624
L10420:
	brl	L10416
L10421:
	ldy	#$1
	lda	[<L620+cp_1],Y
	and	#$ff
	bne	L652
	brl	L651
L652:
	sep	#$20
	longa	off
	lda	#$1a
	ldy	#$1
	cmp	[<L620+cp_1],Y
	rep	#$20
	longa	on
	bcc	L653
	brl	L10422
L653:
L651:
	lda	#$0
	brl	L624
L10422:
	brl	L10416
L10423:
	sep	#$20
	longa	off
	lda	#$ed
	cmp	<L620+token_1
	rep	#$20
	longa	on
	bcc	L654
	brl	L10424
L654:
	lda	#$0
	brl	L624
L10424:
	brl	L10416
L10415:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	252
	dw	L10421-1
	dw	254
	dw	L10417-1
	dw	255
	dw	L10419-1
	dw	L10423-1
L10416:
L10414:
L10413:
	pei	<L620+cp_1+2
	pei	<L620+cp_1
	jsl	~~skip_token
	sta	<L620+cp_1
	stx	<L620+cp_1+2
	brl	L10409
L10410:
	stz	<R0
	lda	[<L620+cp_1]
	and	#$ff
	beq	L656
	brl	L655
L656:
	inc	<R0
L655:
	lda	<R0
	and	#$ff
	brl	L624
L619	equ	21
L620	equ	9
	ends
	efunc
	code
	xdef	~~resolve_linenums
	func
~~resolve_linenums:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L657
	tcs
	phd
	tcd
bp_0	set	4
dest_1	set	0
line_1	set	4
	ldy	#$5
	lda	[<L657+bp_0],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L659
	dey
L659:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L657+bp_0],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L657+bp_0
	adc	<R2
	sta	<L657+bp_0
	lda	<L657+bp_0+2
	adc	<R2+2
	sta	<L657+bp_0+2
L10425:
	lda	[<L657+bp_0]
	and	#$ff
	bne	L660
	brl	L10426
L660:
	sep	#$20
	longa	off
	lda	[<L657+bp_0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L661
	brl	L10427
L661:
	pei	<L657+bp_0+2
	pei	<L657+bp_0
	jsl	~~get_linenum
	sta	<L658+line_1
	pei	<L658+line_1
	jsl	~~find_line
	sta	<L658+dest_1
	stx	<L658+dest_1+2
	pei	<L658+dest_1+2
	pei	<L658+dest_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L658+line_1
	beq	L662
	brl	L10428
L662:
	pei	<L658+dest_1+2
	pei	<L658+dest_1
	pei	<L657+bp_0+2
	pei	<L657+bp_0
	jsl	~~set_address
	sep	#$20
	longa	off
	lda	#$1f
	sta	[<L657+bp_0]
	rep	#$20
	longa	on
L10428:
	brl	L10429
L10427:
	sep	#$20
	longa	off
	lda	[<L657+bp_0]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L663
	brl	L10430
L663:
	pei	<L657+bp_0+2
	pei	<L657+bp_0
	jsl	~~get_address
	sta	<L658+dest_1
	stx	<L658+dest_1+2
	pei	<L658+dest_1+2
	pei	<L658+dest_1
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	pei	<L657+bp_0+2
	pei	<L657+bp_0
	jsl	~~set_address
L10430:
L10429:
	pei	<L657+bp_0+2
	pei	<L657+bp_0
	jsl	~~skip_token
	sta	<L657+bp_0
	stx	<L657+bp_0+2
	brl	L10425
L10426:
L664:
	lda	<L657+2
	sta	<L657+2+4
	lda	<L657+1
	sta	<L657+1+4
	pld
	tsc
	clc
	adc	#L657+4
	tcs
	rtl
L657	equ	18
L658	equ	13
	ends
	efunc
	code
	xdef	~~reset_linenums
	func
~~reset_linenums:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L665
	tcs
	phd
	tcd
bp_0	set	4
dest_1	set	0
sp_1	set	4
line_1	set	8
	clc
	lda	#$6
	adc	<L665+bp_0
	sta	<L666+sp_1
	lda	#$0
	adc	<L665+bp_0+2
	sta	<L666+sp_1+2
	ldy	#$5
	lda	[<L665+bp_0],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L667
	dey
L667:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L665+bp_0],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L665+bp_0
	adc	<R2
	sta	<L665+bp_0
	lda	<L665+bp_0+2
	adc	<R2+2
	sta	<L665+bp_0+2
L10431:
	lda	[<L665+bp_0]
	and	#$ff
	bne	L668
	brl	L10432
L668:
	sep	#$20
	longa	off
	lda	[<L665+bp_0]
	cmp	#<$1f
	rep	#$20
	longa	on
	bne	L670
	brl	L669
L670:
	sep	#$20
	longa	off
	lda	[<L665+bp_0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L671
	brl	L10433
L671:
L669:
L10434:
	sep	#$20
	longa	off
	lda	[<L666+sp_1]
	cmp	#<$1e
	rep	#$20
	longa	on
	bne	L672
	brl	L10435
L672:
	lda	[<L666+sp_1]
	and	#$ff
	bne	L673
	brl	L10435
L673:
	inc	<L666+sp_1
	bne	L674
	inc	<L666+sp_1+2
L674:
	brl	L10434
L10435:
	lda	[<L666+sp_1]
	and	#$ff
	beq	L675
	brl	L10436
L675:
	pea	#^L602
	pea	#<L602
	pea	#<$79c
	pea	#<$82
	pea	#10
	jsl	~~error
L10436:
L10433:
	sep	#$20
	longa	off
	lda	[<L665+bp_0]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L676
	brl	L10437
L676:
	pei	<L665+bp_0+2
	pei	<L665+bp_0
	jsl	~~get_address
	sta	<L666+dest_1
	stx	<L666+dest_1+2
	pei	<L666+dest_1+2
	pei	<L666+dest_1
	jsl	~~get_lineno
	sta	<L666+line_1
	pei	<L666+line_1
	pei	<L666+sp_1+2
	pei	<L666+sp_1
	jsl	~~set_linenum
	clc
	lda	#$3
	adc	<L666+sp_1
	sta	<L666+sp_1
	bcc	L677
	inc	<L666+sp_1+2
L677:
	ldy	#$5
	lda	[<L666+dest_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L678
	dey
L678:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L666+dest_1],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L666+dest_1
	adc	<R2
	sta	<R0
	lda	<L666+dest_1+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L665+bp_0+2
	pei	<L665+bp_0
	jsl	~~set_address
	brl	L10438
L10437:
	sep	#$20
	longa	off
	lda	[<L665+bp_0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L679
	brl	L10439
L679:
savedcurr_2	set	10
	lda	|~~basicvars+62
	sta	<L666+savedcurr_2
	lda	|~~basicvars+62+2
	sta	<L666+savedcurr_2+2
	lda	<L665+bp_0
	sta	|~~basicvars+62
	lda	<L665+bp_0+2
	sta	|~~basicvars+62+2
	pei	<L665+bp_0+2
	pei	<L665+bp_0
	jsl	~~get_linenum
	pha
	pea	#<$86
	pea	#6
	jsl	~~error
	lda	<L666+savedcurr_2
	sta	|~~basicvars+62
	lda	<L666+savedcurr_2+2
	sta	|~~basicvars+62+2
	clc
	lda	#$3
	adc	<L666+sp_1
	sta	<L666+sp_1
	bcc	L680
	inc	<L666+sp_1+2
L680:
L10439:
L10438:
	pei	<L665+bp_0+2
	pei	<L665+bp_0
	jsl	~~skip_token
	sta	<L665+bp_0
	stx	<L665+bp_0+2
	brl	L10431
L10432:
L681:
	lda	<L665+2
	sta	<L665+2+4
	lda	<L665+1
	sta	<L665+1+4
	pld
	tsc
	clc
	adc	#L665+4
	tcs
	rtl
L665	equ	26
L666	equ	13
	ends
	efunc
	data
L602:
	db	$74,$6F,$6B,$65,$6E,$73,$00
	ends
	code
	func
~~expand_linenum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L683
	tcs
	phd
	tcd
p_0	set	4
a_1	set	0
b_1	set	2
c_1	set	4
line_1	set	6
	lda	[<L683+p_0]
	and	#$ff
	sta	<L684+a_1
	ldy	#$1
	lda	[<L683+p_0],Y
	and	#$ff
	sta	<L684+b_1
	ldy	#$2
	lda	[<L683+p_0],Y
	and	#$ff
	sta	<L684+c_1
	lda	<L684+a_1
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<R0
	lda	<L684+c_1
	eor	<R0
	and	#<$ff
	sta	<L684+line_1
	lda	<L684+line_1
	xba
	and	#$ff00
	sta	<R0
	lda	<L684+a_1
	asl	A
	asl	A
	and	#<$c0
	sta	<R1
	lda	<L684+b_1
	eor	<R1
	and	#<$ff
	sta	<R1
	lda	<R1
	ora	<R0
L685:
	tay
	lda	<L683+2
	sta	<L683+2+4
	lda	<L683+1
	sta	<L683+1+4
	pld
	tsc
	clc
	adc	#L683+4
	tcs
	tya
	rtl
L683	equ	16
L684	equ	9
	ends
	efunc
	data
~~onebyte_token:
	dl	L682+0
	dl	L682+10
	dl	L682+14
	dl	L682+18
	dl	L682+22
	dl	L682+26
	dl	L682+29
	dl	L682+35
	dl	L682+40
	dl	L682+44
	dl	L682+49
	dl	L682+53
	dl	L682+58
	dl	L682+63
	dl	$0
	dl	L682+68
	dl	L682+75
	dl	L682+79
	dl	L682+84
	dl	L682+89
	dl	L682+95
	dl	L682+101
	dl	L682+105
	dl	L682+109
	dl	L682+115
	dl	L682+119
	dl	L682+123
	dl	L682+127
	dl	L682+132
	dl	L682+136
	dl	L682+142
	dl	L682+146
	dl	L682+150
	dl	L682+154
	dl	L682+159
	dl	L682+163
	dl	L682+167
	dl	L682+173
	dl	L682+176
	dl	L682+180
	dl	L682+186
	dl	L682+193
	dl	L682+197
	dl	L682+201
	dl	L682+204
	dl	L682+208
	dl	L682+212
	dl	L682+219
	dl	L682+227
	dl	L682+230
	dl	L682+237
	dl	L682+241
	dl	L682+245
	dl	L682+249
	dl	L682+253
	dl	L682+257
	dl	L682+261
	dl	L682+265
	dl	L682+268
	dl	L682+273
	dl	L682+277
	dl	L682+281
	dl	L682+286
	dl	L682+291
	dl	L682+296
	dl	L682+303
	dl	L682+310
	dl	L682+316
	dl	L682+324
	dl	L682+329
	dl	L682+338
	dl	$0,$0,$0
	dl	L682+342
	dl	L682+347
	dl	L682+350
	dl	L682+358
	dl	L682+363
	dl	L682+369
	dl	L682+378
	dl	L682+382
	dl	L682+387
	dl	L682+392
	dl	L682+398
	dl	L682+404
	dl	L682+410
	dl	L682+415
	dl	L682+420
	dl	L682+426
	dl	L682+432
	dl	L682+438
	dl	L682+442
	dl	L682+446
	dl	L682+451
	dl	L682+455
	dl	L682+459
	dl	L682+464
	dl	L682+468
	dl	L682+476
	dl	L682+485
	dl	L682+489
	dl	L682+495
	dl	L682+500
	dl	L682+505
	dl	L682+508
	dl	L682+514
	dl	L682+518
	dl	L682+524
	dl	L682+529
	dl	L682+534
	dl	L682+539
	dl	L682+542
	dl	L682+546
	dl	L682+551
	dl	L682+557
	dl	L682+562
	dl	L682+567
	dl	L682+571
	dl	L682+578
	dl	L682+585
	dl	L682+593
	dl	L682+600
	dl	L682+604
	dl	L682+609
	dl	L682+616
	dl	L682+622
	dl	L682+628
	dl	L682+634
	ends
	data
L682:
	db	$4F,$54,$48,$45,$52,$57,$49,$53,$45,$00,$41,$4E,$44,$00,$44
	db	$49,$56,$00,$45,$4F,$52,$00,$4D,$4F,$44,$00,$4F,$52,$00,$45
	db	$52,$52,$4F,$52,$00,$4C,$49,$4E,$45,$00,$4F,$46,$46,$00,$53
	db	$54,$45,$50,$00,$53,$50,$43,$00,$54,$41,$42,$28,$00,$45,$4C
	db	$53,$45,$00,$54,$48,$45,$4E,$00,$4F,$50,$45,$4E,$49,$4E,$00
	db	$50,$54,$52,$00,$50,$41,$47,$45,$00,$54,$49,$4D,$45,$00,$4C
	db	$4F,$4D,$45,$4D,$00,$48,$49,$4D,$45,$4D,$00,$41,$42,$53,$00
	db	$41,$43,$53,$00,$41,$44,$56,$41,$4C,$00,$41,$53,$43,$00,$41
	db	$53,$4E,$00,$41,$54,$4E,$00,$42,$47,$45,$54,$00,$43,$4F,$53
	db	$00,$43,$4F,$55,$4E,$54,$00,$44,$45,$47,$00,$45,$52,$4C,$00
	db	$45,$52,$52,$00,$45,$56,$41,$4C,$00,$45,$58,$50,$00,$45,$58
	db	$54,$00,$46,$41,$4C,$53,$45,$00,$46,$4E,$00,$47,$45,$54,$00
	db	$49,$4E,$4B,$45,$59,$00,$49,$4E,$53,$54,$52,$28,$00,$49,$4E
	db	$54,$00,$4C,$45,$4E,$00,$4C,$4E,$00,$4C,$4F,$47,$00,$4E,$4F
	db	$54,$00,$4F,$50,$45,$4E,$55,$50,$00,$4F,$50,$45,$4E,$4F,$55
	db	$54,$00,$50,$49,$00,$50,$4F,$49,$4E,$54,$28,$00,$50,$4F,$53
	db	$00,$52,$41,$44,$00,$52,$4E,$44,$00,$53,$47,$4E,$00,$53,$49
	db	$4E,$00,$53,$51,$52,$00,$54,$41,$4E,$00,$54,$4F,$00,$54,$52
	db	$55,$45,$00,$55,$53,$52,$00,$56,$41,$4C,$00,$56,$50,$4F,$53
	db	$00,$43,$48,$52,$24,$00,$47,$45,$54,$24,$00,$49,$4E,$4B,$45
	db	$59,$24,$00,$4C,$45,$46,$54,$24,$28,$00,$4D,$49,$44,$24,$28
	db	$00,$52,$49,$47,$48,$54,$24,$28,$00,$53,$54,$52,$24,$00,$53
	db	$54,$52,$49,$4E,$47,$24,$28,$00,$45,$4F,$46,$00,$57,$48,$45
	db	$4E,$00,$4F,$46,$00,$45,$4E,$44,$43,$41,$53,$45,$00,$45,$4C
	db	$53,$45,$00,$45,$4E,$44,$49,$46,$00,$45,$4E,$44,$57,$48,$49
	db	$4C,$45,$00,$50,$54,$52,$00,$50,$41,$47,$45,$00,$54,$49,$4D
	db	$45,$00,$4C,$4F,$4D,$45,$4D,$00,$48,$49,$4D,$45,$4D,$00,$53
	db	$4F,$55,$4E,$44,$00,$42,$50,$55,$54,$00,$43,$41,$4C,$4C,$00
	db	$43,$48,$41,$49,$4E,$00,$43,$4C,$45,$41,$52,$00,$43,$4C,$4F
	db	$53,$45,$00,$43,$4C,$47,$00,$43,$4C,$53,$00,$44,$41,$54,$41
	db	$00,$44,$45,$46,$00,$44,$49,$4D,$00,$44,$52,$41,$57,$00,$45
	db	$4E,$44,$00,$45,$4E,$44,$50,$52,$4F,$43,$00,$45,$4E,$56,$45
	db	$4C,$4F,$50,$45,$00,$46,$4F,$52,$00,$47,$4F,$53,$55,$42,$00
	db	$47,$4F,$54,$4F,$00,$47,$43,$4F,$4C,$00,$49,$46,$00,$49,$4E
	db	$50,$55,$54,$00,$4C,$45,$54,$00,$4C,$4F,$43,$41,$4C,$00,$4D
	db	$4F,$44,$45,$00,$4D,$4F,$56,$45,$00,$4E,$45,$58,$54,$00,$4F
	db	$4E,$00,$56,$44,$55,$00,$50,$4C,$4F,$54,$00,$50,$52,$49,$4E
	db	$54,$00,$50,$52,$4F,$43,$00,$52,$45,$41,$44,$00,$52,$45,$4D
	db	$00,$52,$45,$50,$45,$41,$54,$00,$52,$45,$50,$4F,$52,$54,$00
	db	$52,$45,$53,$54,$4F,$52,$45,$00,$52,$45,$54,$55,$52,$4E,$00
	db	$52,$55,$4E,$00,$53,$54,$4F,$50,$00,$43,$4F,$4C,$4F,$55,$52
	db	$00,$54,$52,$41,$43,$45,$00,$55,$4E,$54,$49,$4C,$00,$57,$49
	db	$44,$54,$48,$00,$4F,$53,$43,$4C,$49,$00
	ends
	data
~~twobyte_token:
	dl	L686+0
	dl	L686+5
	dl	L686+12
	dl	L686+17
	dl	L686+24
	dl	L686+30
	dl	L686+40
	dl	L686+45
	dl	L686+51
	dl	L686+56
	dl	L686+62
	dl	L686+67
	dl	L686+71
	dl	L686+79
	dl	L686+87
	dl	L686+92
	dl	L686+100
	dl	L686+106
	dl	L686+112
	dl	L686+119
	dl	L686+125
	dl	L686+132
	ends
	data
L686:
	db	$43,$41,$53,$45,$00,$43,$49,$52,$43,$4C,$45,$00,$46,$49,$4C
	db	$4C,$00,$4F,$52,$49,$47,$49,$4E,$00,$50,$4F,$49,$4E,$54,$00
	db	$52,$45,$43,$54,$41,$4E,$47,$4C,$45,$00,$53,$57,$41,$50,$00
	db	$57,$48,$49,$4C,$45,$00,$57,$41,$49,$54,$00,$4D,$4F,$55,$53
	db	$45,$00,$51,$55,$49,$54,$00,$53,$59,$53,$00,$49,$4E,$53,$54
	db	$41,$4C,$4C,$00,$4C,$49,$42,$52,$41,$52,$59,$00,$54,$49,$4E
	db	$54,$00,$45,$4C,$4C,$49,$50,$53,$45,$00,$42,$45,$41,$54,$53
	db	$00,$54,$45,$4D,$50,$4F,$00,$56,$4F,$49,$43,$45,$53,$00,$56
	db	$4F,$49,$43,$45,$00,$53,$54,$45,$52,$45,$4F,$00,$4F,$56,$45
	db	$52,$4C,$41,$59,$00
	ends
	data
~~command_token:
	dl	L687+0
	dl	L687+7
	dl	L687+12
	dl	L687+19
	dl	L687+26
	dl	L687+31
	dl	L687+36
	dl	L687+41
	dl	L687+46
	dl	L687+51
	dl	L687+55
	dl	L687+59
	dl	L687+68
	dl	L687+73
	dl	L687+82
	dl	L687+91
	dl	L687+96
	dl	L687+102
	ends
	data
L687:
	db	$41,$50,$50,$45,$4E,$44,$00,$41,$55,$54,$4F,$00,$43,$52,$55
	db	$4E,$43,$48,$00,$44,$45,$4C,$45,$54,$45,$00,$45,$44,$49,$54
	db	$00,$48,$45,$4C,$50,$00,$4C,$49,$53,$54,$00,$4C,$4F,$41,$44
	db	$00,$4C,$56,$41,$52,$00,$4E,$45,$57,$00,$4F,$4C,$44,$00,$52
	db	$45,$4E,$55,$4D,$42,$45,$52,$00,$53,$41,$56,$45,$00,$54,$45
	db	$58,$54,$4C,$4F,$41,$44,$00,$54,$45,$58,$54,$53,$41,$56,$45
	db	$00,$54,$57,$49,$4E,$00,$54,$57,$49,$4E,$4F,$00,$49,$4E,$53
	db	$54,$41,$4C,$4C,$00
	ends
	data
~~other_token:
	dl	L688+0
	dl	L688+4
	ends
	data
L688:
	db	$53,$55,$4D,$00,$42,$45,$41,$54,$00
	ends
	data
~~nospace:
	db	$A4,$F2,$B8,$91,$D1,$8A,$A7,$B0,$C0,$C1
	db	$C2,$C4,$0
	ends
	code
	xdef	~~reformat
	func
~~reformat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L690
	tcs
	phd
	tcd
tp_0	set	4
tokenbuf_0	set	8
count_1	set	0
cp_1	set	2
p_1	set	6
token_1	set	10
line_1	set	11
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L691+line_1
	stx	<L691+line_1+2
	lda	<L691+line_1
	sta	<L691+cp_1
	lda	<L691+line_1+2
	sta	<L691+cp_1+2
	ldy	#$1
	lda	[<L690+tp_0],Y
	and	#$ff
	sta	<R0
	lda	[<L690+tp_0]
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	pha
	pea	#^L689
	pea	#<L689
	pei	<L691+cp_1+2
	pei	<L691+cp_1
	pea	#12
	jsl	~~sprintf
	sta	<L691+count_1
	ldy	#$0
	lda	<L691+count_1
	bpl	L692
	dey
L692:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L691+cp_1
	adc	<R0
	sta	<L691+cp_1
	lda	<L691+cp_1+2
	adc	<R0+2
	sta	<L691+cp_1+2
	clc
	lda	#$3
	adc	<L690+tp_0
	sta	<L690+tp_0
	bcc	L693
	inc	<L690+tp_0+2
L693:
	sep	#$20
	longa	off
	lda	[<L690+tp_0]
	sta	<L691+token_1
	rep	#$20
	longa	on
L10440:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L694
	brl	L10441
L694:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$7f
	rep	#$20
	longa	on
	bcc	L695
	brl	L10442
L695:
	sep	#$20
	longa	off
	lda	<L691+token_1
	sta	[<L691+cp_1]
	rep	#$20
	longa	on
	inc	<L691+cp_1
	bne	L696
	inc	<L691+cp_1+2
L696:
	inc	<L690+tp_0
	bne	L697
	inc	<L690+tp_0+2
L697:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L698
	brl	L10443
L698:
L10446:
	sep	#$20
	longa	off
	lda	[<L690+tp_0]
	sta	<L691+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L691+token_1
	sta	[<L691+cp_1]
	rep	#$20
	longa	on
	inc	<L691+cp_1
	bne	L699
	inc	<L691+cp_1+2
L699:
	inc	<L690+tp_0
	bne	L700
	inc	<L690+tp_0+2
L700:
L10444:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$22
	rep	#$20
	longa	on
	bne	L702
	brl	L701
L702:
	sep	#$20
	longa	off
	lda	[<L690+tp_0]
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L703
	brl	L10446
L703:
L701:
L10445:
L10443:
	brl	L10447
L10442:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$8d
	rep	#$20
	longa	on
	beq	L704
	brl	L10448
L704:
	clc
	lda	#$1
	adc	<L690+tp_0
	sta	<R0
	lda	#$0
	adc	<L690+tp_0+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~expand_linenum
	pha
	pea	#^L689+3
	pea	#<L689+3
	pei	<L691+cp_1+2
	pei	<L691+cp_1
	pea	#12
	jsl	~~sprintf
	sta	<L691+count_1
	ldy	#$0
	lda	<L691+count_1
	bpl	L705
	dey
L705:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L691+cp_1
	adc	<R0
	sta	<L691+cp_1
	lda	<L691+cp_1+2
	adc	<R0+2
	sta	<L691+cp_1+2
	clc
	lda	#$4
	adc	<L690+tp_0
	sta	<L690+tp_0
	bcc	L706
	inc	<L690+tp_0+2
L706:
	brl	L10449
L10448:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$f4
	rep	#$20
	longa	on
	bne	L708
	brl	L707
L708:
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$dc
	rep	#$20
	longa	on
	beq	L709
	brl	L10450
L709:
L707:
	lda	<L691+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#$fe04
	adc	#<~~onebyte_token
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L691+p_1
	ldy	#$2
	lda	(<R2),Y
	sta	<L691+p_1+2
	pei	<L691+p_1+2
	pei	<L691+p_1
	pei	<L691+cp_1+2
	pei	<L691+cp_1
	jsl	~~strcpy
	pei	<L691+p_1+2
	pei	<L691+p_1
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	clc
	lda	<L691+cp_1
	adc	<R0
	sta	<L691+cp_1
	lda	<L691+cp_1+2
	adc	<R0+2
	sta	<L691+cp_1+2
	inc	<L690+tp_0
	bne	L710
	inc	<L690+tp_0+2
L710:
L10451:
	sep	#$20
	longa	off
	lda	[<L690+tp_0]
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L711
	brl	L10452
L711:
	sep	#$20
	longa	off
	lda	[<L690+tp_0]
	sta	[<L691+cp_1]
	rep	#$20
	longa	on
	inc	<L691+cp_1
	bne	L712
	inc	<L691+cp_1+2
L712:
	inc	<L690+tp_0
	bne	L713
	inc	<L690+tp_0+2
L713:
	brl	L10451
L10452:
	brl	L10453
L10450:
	lda	<L691+token_1
	and	#$ff
	brl	L10454
L10456:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L690+tp_0],Y
	sta	<L691+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$8e
	rep	#$20
	longa	on
	bcs	L715
	brl	L714
L715:
	sep	#$20
	longa	off
	lda	#$a3
	cmp	<L691+token_1
	rep	#$20
	longa	on
	bcc	L716
	brl	L10457
L716:
L714:
	pea	#<$7
	pea	#4
	jsl	~~error
L10457:
	lda	<L691+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#$fdc8
	adc	#<~~twobyte_token
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L691+p_1
	ldy	#$2
	lda	(<R2),Y
	sta	<L691+p_1+2
	clc
	lda	#$2
	adc	<L690+tp_0
	sta	<L690+tp_0
	bcc	L717
	inc	<L690+tp_0+2
L717:
	brl	L10455
L10458:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L690+tp_0],Y
	sta	<L691+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$8e
	rep	#$20
	longa	on
	bcs	L719
	brl	L718
L719:
	sep	#$20
	longa	off
	lda	#$9f
	cmp	<L691+token_1
	rep	#$20
	longa	on
	bcc	L720
	brl	L10459
L720:
L718:
	pea	#<$7
	pea	#4
	jsl	~~error
L10459:
	lda	<L691+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#$fdc8
	adc	#<~~command_token
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L691+p_1
	ldy	#$2
	lda	(<R2),Y
	sta	<L691+p_1+2
	clc
	lda	#$2
	adc	<L690+tp_0
	sta	<L690+tp_0
	bcc	L721
	inc	<L690+tp_0+2
L721:
	brl	L10455
L10460:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L690+tp_0],Y
	sta	<L691+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L691+token_1
	cmp	#<$8e
	rep	#$20
	longa	on
	bcs	L723
	brl	L722
L723:
	sep	#$20
	longa	off
	lda	#$8f
	cmp	<L691+token_1
	rep	#$20
	longa	on
	bcc	L724
	brl	L10461
L724:
L722:
	pea	#<$7
	pea	#4
	jsl	~~error
L10461:
	lda	<L691+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#$fdc8
	adc	#<~~other_token
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L691+p_1
	ldy	#$2
	lda	(<R2),Y
	sta	<L691+p_1+2
	clc
	lda	#$2
	adc	<L690+tp_0
	sta	<L690+tp_0
	bcc	L725
	inc	<L690+tp_0+2
L725:
	brl	L10455
L10462:
	lda	<L691+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#$fe04
	adc	#<~~onebyte_token
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L691+p_1
	ldy	#$2
	lda	(<R2),Y
	sta	<L691+p_1+2
	inc	<L690+tp_0
	bne	L726
	inc	<L690+tp_0+2
L726:
	brl	L10455
L10454:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	198
	dw	L10460-1
	dw	199
	dw	L10458-1
	dw	200
	dw	L10456-1
	dw	L10462-1
L10455:
	lda	<L691+cp_1
	cmp	<L691+line_1
	bne	L727
	lda	<L691+cp_1+2
	cmp	<L691+line_1+2
L727:
	bne	L728
	brl	L10463
L728:
	clc
	lda	#$ffff
	adc	<L691+cp_1
	sta	<R0
	lda	#$ffff
	adc	<L691+cp_1+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	pha
	jsl	~~isalnum
	tax
	bne	L729
	brl	L10463
L729:
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L691+cp_1]
	rep	#$20
	longa	on
	inc	<L691+cp_1
	bne	L730
	inc	<L691+cp_1+2
L730:
L10463:
	pei	<L691+p_1+2
	pei	<L691+p_1
	pei	<L691+cp_1+2
	pei	<L691+cp_1
	jsl	~~strcpy
	pei	<L691+p_1+2
	pei	<L691+p_1
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	clc
	lda	<L691+cp_1
	adc	<R0
	sta	<L691+cp_1
	lda	<L691+cp_1+2
	adc	<R0+2
	sta	<L691+cp_1+2
	lda	[<L690+tp_0]
	and	#$ff
	pha
	jsl	~~isalnum
	tax
	bne	L731
	brl	L10464
L731:
n_2	set	15
	stz	<L691+n_2
	brl	L10468
L10467:
L10465:
	inc	<L691+n_2
L10468:
	ldx	<L691+n_2
	lda	|~~nospace,X
	and	#$ff
	bne	L733
	brl	L732
L733:
	sep	#$20
	longa	off
	ldx	<L691+n_2
	lda	|~~nospace,X
	cmp	<L691+token_1
	rep	#$20
	longa	on
	beq	L734
	brl	L10467
L734:
L732:
L10466:
	ldx	<L691+n_2
	lda	|~~nospace,X
	and	#$ff
	beq	L735
	brl	L10469
L735:
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L691+cp_1]
	rep	#$20
	longa	on
	inc	<L691+cp_1
	bne	L736
	inc	<L691+cp_1+2
L736:
L10469:
L10464:
L10453:
L10449:
L10447:
	sep	#$20
	longa	off
	lda	[<L690+tp_0]
	sta	<L691+token_1
	rep	#$20
	longa	on
	brl	L10440
L10441:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L691+cp_1]
	rep	#$20
	longa	on
	pea	#<$1
	pei	<L690+tokenbuf_0+2
	pei	<L690+tokenbuf_0
	pei	<L691+line_1+2
	pei	<L691+line_1
	jsl	~~tokenize
	pei	<L691+line_1+2
	pei	<L691+line_1
	jsl	~~free
	pei	<L690+tokenbuf_0+2
	pei	<L690+tokenbuf_0
	jsl	~~get_linelen
L737:
	tay
	lda	<L690+2
	sta	<L690+2+8
	lda	<L690+1
	sta	<L690+1+8
	pld
	tsc
	clc
	adc	#L690+8
	tcs
	tya
	rtl
L690	equ	29
L691	equ	13
	ends
	efunc
	data
L689:
	db	$25,$64,$00,$25,$64,$00
	ends
	xref	~~error
	xref	~~tonumber
	xref	~~todigit
	xref	~~find_linestart
	xref	~~find_line
	xref	~~skip
	xref	~~skip_blanks
	xref	~~isident
	xref	~~isidchar
	xref	~~isidstart
	xref	~~isxdigit
	xref	~~toupper
	xref	~~tolower
	xref	~~islower
	xref	~~isalpha
	xref	~~isalnum
	xref	~~strlen
	xref	~~strncmp
	xref	~~memcpy
	xref	~~strcpy
	xref	~~free
	xref	~~malloc
	xref	~~sprintf
	udata
~~numbered
	ds	1
	ends
	udata
~~firstitem
	ds	1
	ends
	udata
~~linestart
	ds	1
	ends
	udata
~~lasterror
	ds	2
	ends
	udata
~~indentation
	ds	2
	ends
	udata
~~brackets
	ds	2
	ends
	udata
~~source
	ds	2
	ends
	udata
~~next
	ds	2
	ends
	udata
~~lp
	ds	4
	ends
	udata
~~tokenbase
	ds	4
	ends
	udata
	xdef	~~thisline
~~thisline
	ds	1032
	ends
	xref	~~basicvars
	end
