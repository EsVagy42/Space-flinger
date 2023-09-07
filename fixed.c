#include <gb/gb.h>

//fixed16 is a fixed value with 16 bits, 8 for the fractional part

typedef int16_t fixed16;

#define FIXED_SHIFT 8
#define FIXED_SCALE (1 << FIXED_SHIFT)
#define FIXED_MASK (FIXED_SCALE - 1)

#define FIXED(x) (((fixed16)((x) * FIXED_SCALE)))
#define INT(x) ((x) >> FIXED_SHIFT)

inline fixed16 add(fixed16 a, fixed16 b) {
    return a + b;
}

inline fixed16 sub(fixed16 a, fixed16 b) {
    return a - b;
}

inline fixed16 mul(fixed16 a, fixed16 b) {
    return (fixed16)(((int32_t)a * b) >> FIXED_SHIFT);
}

inline fixed16 div(fixed16 a, fixed16 b) {
    return (fixed16)(((int32_t)a << FIXED_SHIFT) / b);
}

inline fixed16 abs(fixed16 a)
{
    if (a >= 0)
    {
        return a;
    }
    else
    {
        return -a;
    }
}

inline fixed16 sign(fixed16 a)
{
    if (a == 0)
    {
        return FIXED(0);
    }
    else if (a > 0)
    {
        return FIXED(1);
    }
    else
    {
        return FIXED(-1);
    }
}

inline fixed16 sqr(fixed16 a)
{
    return mul(a, a);
}

fixed16 sqrt(fixed16 n) {
    // Define a tolerance for the accuracy of the result
    fixed16 tol = FIXED(0.001);
    
    // Initialize the guess as half of n
    fixed16 x = div(n, FIXED(2));
    
    // Repeat until the difference between x and n/x is less than the tolerance
    while (abs(sub(x, div(n, x))) > tol) {
        // Update x by taking the average of x and n/x
        x = div(add(x, div(n, x)), FIXED(2));
    }
    
    // Return the final approximation
    return x;
}


// A table of precomputed angles and their tangents for the cordic algorithm
// The angles are in degrees and scaled by 256
// The tangents are scaled by 256
const fixed16 cordic_table[][2] = {
    {FIXED(45), FIXED(1)},
    {FIXED(26.565), FIXED(0.5)},
    {FIXED(14.036), FIXED(0.25)},
    {FIXED(7.125), FIXED(0.125)},
    {FIXED(3.576), FIXED(0.0625)},
    {FIXED(1.790), FIXED(0.03125)},
    {FIXED(0.895), FIXED(0.015625)},
    {FIXED(0.448), FIXED(0.0078125)},
    {FIXED(0.224), FIXED(0.00390625)},
    {FIXED(0.112), FIXED(0.001953125)},
    {FIXED(0.056), FIXED(0.0009765625)}
};

// A constant for the correction factor for 11 iterations
// The value is 0.6072529350088813 scaled by 256
#define CORRECTION_FACTOR 155

// A function to rotate a vector (x, y) by a given angle using the cordic algorithm
// The angle is in degrees and scaled by 256
// The x and y pointers are updated with the rotated values
void rotate(fixed16* x, fixed16* y, fixed16 angle) {
    // Initialize the current angle to zero
    fixed16 current_angle = FIXED(0);
    
    // Loop through the cordic table
    for (int8_t i = 0; i < 11; i++) {
        // Get the precomputed angle and tangent from the table
        fixed16 pre_angle = cordic_table[i][0];
        fixed16 pre_tan = cordic_table[i][1];
        
        // Determine the rotation direction based on the sign of the angle difference
        int sign = (sub(angle, current_angle)) > 0 ? 1 : -1;
        
        // Rotate the vector by the precomputed angle in the determined direction
        fixed16 x_new = *x - sign * (*y >> i);
        fixed16 y_new = *y + sign * (*x >> i);
        
        // Update the vector values
        *x = x_new;
        *y = y_new;
        
        // Update the current angle
        current_angle = add(current_angle, sign * pre_angle);
    }

    // Scale the vector by the correction factor
    *x = mul(*x, CORRECTION_FACTOR);
    *y = mul(*y, CORRECTION_FACTOR);
}

//for binary coded decimal numbers. the digits of the decimal number are stored in an uint8_t array
inline void addBCD(uint8_t arr1[], uint8_t arr2[], uint8_t size)
{
    BOOLEAN carry = FALSE;
    for (int8_t i = size - 1; i >= 0; i--)
    {
        arr1[i] += arr2[i] + (carry ? 1 : 0);
        if (arr1[i] >= 0x0A)
        {
            arr1[i] -= 0x0A;
            carry = TRUE;
        }
        else
        {
            carry = FALSE;
        }
    }
}

inline void subBCD(uint8_t arr1[], uint8_t arr2[], uint8_t size)
{
    BOOLEAN borrow = FALSE;
    for (int8_t i = size - 1; i >= 0; i--)
    {
        arr1[i] -= arr2[i] + (borrow ? 1 : 0);
        if (arr1[i] >= 0x0A)
        {
            arr1[i] += 0x0A;
            borrow = TRUE;
        }
        else
        {
            borrow = FALSE;
        }
    }
}

inline void copyBCD(uint8_t arr1[], uint8_t arr2[], uint8_t size)
{
    for (uint8_t i = 0; i < size; i++)
    {
        arr1[i] = arr2[i];
    }
}