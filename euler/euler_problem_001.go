// README - General comments and instructions
//
// Project Euler Problem Solving Programs
// Problem 001
//	If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
//	The sum of these multiples is 23.
//	Find the sum of all the multiples of 3 or 5 below 1000.
//
//	My approach to this is to use several loops to iterate through the multiples.
//  Sum the sums of the multiples of 3 with the multiples of 5.
//  Then, subtract the multiples of (3*5) to remove the duplicates.
// The remaining value should be the correct one.
//
// SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE IT PRODUCE THE CORRECT REFERENCE DATA
//The value of sum_of_multiple for 3 is 18
//The value of sum_of_multiple for 5 is 5
//The value of sum_of_multiple for 15 is 0
//The final value is 23
//END OF LINE
//
// SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE THE INTENDED OUTPUT DATA
//The value of sum_of_multiple for 3 is 166833
//The value of sum_of_multiple for 5 is 99500
//The value of sum_of_multiple for 15 is 33165
//The final value is 233168
//END OF LINE
//
// Play with the working code at https://play.golang.org/p/usrWVV5XAa4
//
package main

import (
    "fmt"
)

func main() {
    // variables
    var inputA = 3
    var inputB = 5
    var multiplelimit = 1000
    // products
    productAB := (inputA * inputB)
    multA := multiple(inputA, multiplelimit)
    multB := multiple(inputB, multiplelimit)
    multC := multiple(productAB, multiplelimit)
    // putting it all together
    sum := multA + multB - multC
    // output the inputs and the results
    fmt.Printf("input A = %d , input B = %d, product C = %d, limit = %d", inputA, inputB, productAB, multiplelimit)
    fmt.Printf(", sum of multiples = %d + %d - %d = %d", multA, multB, multC, sum)
}

func multiple (a int, b int) int {
    var c int
    for i, d := 0, a; i<(b-d); {
        i = i + d
        c = c + i
    }
    return c
}