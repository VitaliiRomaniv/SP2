#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>

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
		printf("C result = %lf", (a - c * 4 - 1) / (c / 31 + tan(a * d)));
	}else{
		if((a == 0) || ((c - d + 1) == 0)){
			printf("Error: Div by zero!");
			return -1;
		}
		printf("C result = %lf", (tan(d / a + 4) + d) / (c - d + 1));
	}


	double res = calc(a, c, d);
	printf("\nResult of function calc is: %f\n", res);
	return 0;
}