#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>
#include <iostream>


extern "C" double calc(double, float, float);

int main(){
	double a;	  //lf
	float c, d;   //f
	

	printf("Enter a: ");
	scanf_s("%lf", &a);

	printf("Enter c: ");
	scanf_s("%f", &c);

	printf("Enter d: ");
	scanf_s("%f", &d);


	if(c > d){
		if ((c / 31 + tan(a * d)) == 0) {
			printf("Error: Div by zero!");
			return -1;
		}

		double first_step   = (a - c * 4 - 1);
		double second_step  = (c / 31) + tan(a * d);
		double res			= first_step / second_step;

		printf("C result = %lf", res);

	}else{
		if((a == 0) || ((c - d + 1) == 0)){
			printf("Error: Div by zero!");
			return -1;
		}
	
		double first_step = (tan(d / a + 4) + d);
		float second_step = (c - d + 1);
		double res = first_step / second_step;
		printf("C result = %lf", res);
	}

	double res = calc(a, c, d);
	printf("\nResult of function calc is: %f\n", res);
	return 0;
}