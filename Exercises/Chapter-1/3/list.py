"""
 - Appending elements.
 - Automatically resizing when the array exceeds its current capacity.
 - Printing the current capacity of the array and the number of elements it holds.
 - Implement and compare the performance of resizing by copying elements into a larger array (as done in Python).
 - **Challenge**: Try optimizing the resizing mechanism (e.g., doubling the size, etc.) and analyze the time complexity for different operations.
"""
class ListPy:
    def __init__(self):
        self.capacity = 1  # Initial capacity
        self.size = 0      # Number of elements in the list
        self.array = [None] * self.capacity  # The array itself
    def push(self,val):
        if self.size == self.capacity:
            self._resize(self.capacity*2)
        self.array[self.size] = val
        self.size += 1
    def pop(self):
        if self.size == 0:
            return None
        val = self.array[self.size -1]
        self.size -=1
        return val
    def clr(self):
        self.array = [None] * self.capacity
        self.size = 0
    def find(self,value):
        for i in range(self.size):
            if self.array[i] == value:
                return i
        return -1
    def insert(self, index, value):
        if index < 0 or index > self.size:
            raise IndexError("Index out of bounds")

        # Resize if needed
        if self.size == self.capacity:
            self._resize(self.capacity * 2)

        # Shift elements to the right to make space
        for i in range(self.size, index, -1):
            self.array[i] = self.array[i - 1]

        # Insert the new element
        self.array[index] = value
        self.size += 1
    def remove(self, value):
        index = self.find(value)
        if index == -1:
            return None

        # Shift elements to the left to remove the element
        for i in range(index, self.size - 1):
            self.array[i] = self.array[i + 1]

        self.size -= 1
        # Optional resize after removal
        if self.size < self.capacity // 4 and self.capacity > 1:
            self._resize(self.capacity // 2)

        return value

    def info(self):
        elements_with_index = {i: self.array[i] for i in range(self.size)}
        return {
            "size": self.size,
            "capacity": self.capacity,
            "elements": elements_with_index,
            "elements_list": list(self.array[:self.size]),
        }

    def index(self, value):
        return self.find(value)

    def __len__(self):
        return self.size

    def _resize(self, new_capacity):
        new_array = [None] * new_capacity  # Create a new array with the new capacity
        for i in range(self.size):  # Copy the old array elements to the new array
            new_array[i] = self.array[i]
        self.array = new_array  # Point the array to the new one
        self.capacity = new_capacity  # Update the capacity

# Test the class
list_py = ListPy()

# Add some elements
list_py.push(10)
list_py.push(20)
list_py.push(30)
list_py.push(40)

# Print info
print("PUSH: ",list_py.info())

# Pop an element
list_py.pop()
print("POP: ",list_py.info())

# Insert at an index
list_py.insert(1, 50)
print("INSERT:(1, 50): ",list_py.info())

# Remove an element
list_py.remove(20)
print("REMOVE:20: ",list_py.info())

# Clear the list
list_py.clr()
print("CLEAR: ",list_py.info())