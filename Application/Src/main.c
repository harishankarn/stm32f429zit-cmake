// Find where the led is connected to the board in schematic
// Board : STM32F429ZI
// Port: Port G
// Pin: 13 [MODER bit 27:26]
// Address Bus : AHB1 180 MHZ @ GPIO - G
#include "stm32f4xx.h"

#define GPIOGEN  			(1U<<6)
#define PIN13				(1U<<13)
#define LED_PIN 			PIN13


int main(void){
	RCC->AHB1ENR |= GPIOGEN;

	GPIOG->MODER |= (1U<<26); 	// sets only Bit 26 to one
	GPIOG->MODER &= ~(1U<<27);	// sets only Bit 27 to zero
	while(1)
	{
		GPIOG->ODR ^= LED_PIN;
		for(int i=0;i<1000000;i++);
	}
}
