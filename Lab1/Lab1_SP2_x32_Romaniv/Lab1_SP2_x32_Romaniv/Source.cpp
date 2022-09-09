#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <iostream>

extern "C" int calc(signed short, signed char, signed short);

extern "C" int K = 0x56987018;

// Y = 4 * (B2 - C1) + D2/4 + K


int main()
{
	char arr[256];

	signed long		checker;

	signed short		  b;
	signed char			  c;
	signed short		  d;

	//Enter B value
	printf("B: ");
	scanf("%s", arr);

	//Check if input is correct
	if ((strlen(arr) > 6 && arr[0] == '-') ||
		(strlen(arr) > 5 && arr[0] != '-')) {
		printf("Two bytes overflow");
		return -1;
	}

	//Check if B has the correct size
	checker = atoi(arr);
	if (checker > 32767 || checker < -32767) {
		printf("Two bytes overflow");
		return -1;
	}
	
	//initialise b
	b = (short)checker;

	//Enter C value
	printf("C: ");
	scanf("%s", arr);

	//Check if input is correct
	if ((strlen(arr) > 4 && arr[0] == '-') ||
		(strlen(arr) > 3 && arr[0] != '-')) {
		printf("One byte overflow");
		return -1;
	}

	//Check if C has the correct size
	checker = atoi(arr);
	if (checker > 127 || checker < -127) {
		printf("One byte overflow");
		return -1;
	}
	c = (char)checker;

	//Enter D value
	printf("D: ");
	scanf("%s", arr);

	//Check if input is correct
	if ((strlen(arr) > 6 && arr[0] == '-') ||
		(strlen(arr) > 5 && arr[0] != '-')) {
		printf("Two bytes overflow");
		return -1;
	}

	//Check if D has the correct size
	checker = atoi(arr);
	if (checker > 32767 || checker < -32767) {
		printf("Two bytes overflow");
		return -1;
	}
	d = (short)checker;



	printf("\n4 * (B - C)+ D/4 + K =       %d\n", (signed int)(4 * (b - c) + (d / 4) + K));
	signed int  res = calc(b, c, d);
	printf("\nResult of procedure calc is: %d\n", res);

	std::cout << "\n\n\n\n Finish" << std::endl;
	return 0;
}