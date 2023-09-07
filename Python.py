import numpy as np                   # Import NumPy for mathematical operations
from collections import Counter    # Import Counter for counting color frequencies
import random                       # Import random for generating random binary numbers
import psycopg2                     # Import psycopg2 for PostgreSQL database interaction

# Sample data for colors
colors = ["Red", "Blue", "Red", "Green", "Blue", "Red"]
# Sample data for RGB colors
rgb_colors = [(255, 0, 0), (0, 0, 255), (0, 255, 0)]

# 1. Calculate the mean color
# Calculate the mean color as the average of RGB values
mean_color = tuple(np.mean(rgb_colors, axis=0).astype(int))

# 2. Find the most worn color
# Count the frequency of each color and find the most common color
color_counts = Counter(colors)
most_worn_color = color_counts.most_common(1)[0][0]

# 3. Find the median color
# Sort the colors and find the middle color as the median
sorted_colors = sorted(colors)
median_index = len(sorted_colors) // 2
median_color = sorted_colors[median_index]

# 4. Calculate variance of colors
# Calculate the variance of colors based on RGB values
mean_color_rgb = np.mean(rgb_colors, axis=0)
variance = np.mean([np.linalg.norm(np.array(c) - mean_color_rgb) ** 2 for c in rgb_colors])

# 5. Calculate probability of choosing red
# Calculate the probability of choosing red from the color frequencies
red_frequency = color_counts.get("Red", 0)
total_colors = len(colors)
probability_red = red_frequency / total_colors

# 6. Save colors and their frequencies in PostgreSQL database
try:
    conn = psycopg2.connect(
        database="your_database_name",  # Replace with database name
        user="your_username",           # Replace with username
        password="your_password",       # Replace with password
        host="your_host",               # Replace with host
        port="your_port"                # Replace with port
    )

    cursor = conn.cursor()

    for color, count in color_counts.items():
        # Insert color and its frequency into the database
        cursor.execute("INSERT INTO colors (color, frequency) VALUES (%s, %s)", (color, count))

    conn.commit()
    print("Colors and frequencies saved to PostgreSQL database")

except psycopg2.Error as e:
    print("Error:", e)

finally:
    if conn:
        conn.close()

# 7. Recursive Number Search
def recursive_search(numbers, target, start=0, end=None):
    if end is None:
        end = len(numbers) - 1
    if start > end:
        return False
    mid = (start + end) // 2
    if numbers[mid] == target:
        return True
    elif numbers[mid] < target:
        return recursive_search(numbers, target, mid + 1, end)
    else:
        return recursive_search(numbers, target, start, mid - 1)

# 8. Generate Random Binary Number and Convert to Base 10
random_binary = ''.join(random.choice('01') for _ in range(4))
decimal_number = int(random_binary, 2)

# 9. Sum the First 50 Fibonacci Numbers
def fibonacci_sum(n):
    fib = [0] * (n + 1)
    fib[1] = 1
    total = 0
    for i in range(2, n + 1):
        fib[i] = fib[i - 1] + fib[i - 2]
        total += fib[i]
    return total

sum_of_fibonacci = fibonacci_sum(50)

# Print results
print("1. Mean Color:", mean_color)
print("2. Most Worn Color:", most_worn_color)
print("3. Median Color:", median_color)
print("4. Variance of Colors:", variance)
print("5. Probability of Choosing Red:", probability_red)
print("7. Recursive Number Search for 5:", recursive_search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5))
print("8. Random Binary Number:", random_binary)
print("   Converted to Decimal:", decimal_number)
print("9. Sum of First 50 Fibonacci Numbers:", sum_of_fibonacci)
