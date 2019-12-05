
# Generate payment reference based on current Date:

1. get current second, minute,hour of day, day of month, curent month, current year - 2000
2. base the max value of each responding value to decide the bit length of each field
3. base 32 encode
4. the encoded sequece should be second first, with year field the last 
