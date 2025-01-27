import os

# Fetch the variable from the environment
test_value = os.getenv('TEST_VALUE', 'default_value')

# Print the value
print(f"The value of TEST_VALUE is: {test_value}")
