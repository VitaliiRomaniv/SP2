#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <iostream>

extern "C" int calc(signed short, signed char, signed short);

extern "C" int K = 1452830744;

int main()
{
	char arr[256];

	signed long		checker;

	signed short		  b;
	signed char			  c;
	signed short		  d;


	printf("B: ");
	scanf("%s", arr);

	if ((strlen(arr) > 6 && arr[0] == '-') ||
		(strlen(arr) > 5 && arr[0] != '-')) {
		printf("Two bytes overflow");
		return -1;
	}

	checker = atoi(arr);
	if (checker > 32767 || checker < -32767) {
		printf("Two bytes overflow");
		return -1;
	}
	b = (short)checker;


	printf("C: ");
	scanf("%s", arr);

	if ((strlen(arr) > 4 && arr[0] == '-') ||
		(strlen(arr) > 3 && arr[0] != '-')) {
		printf("One byte overflow");
		return -1;
	}

	checker = atoi(arr);
	if (checker > 127 || checker < -127) {
		printf("One byte overflow");
		return -1;
	}
	c = (char)checker;

	printf("D: ");
	scanf("%s", arr);

	if ((strlen(arr) > 6 && arr[0] == '-') ||
		(strlen(arr) > 5 && arr[0] != '-')) {
		printf("Two bytes overflow");
		return -1;
	}

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