def access_array(arr, index):
    try:
        print(f"Value at index {index}: {arr[index]}")
    except IndexError:
        print("Error: Index out of bounds.")

if __name__ == "__main__":
    my_array = [1, 2, 3, 4, 5]
    access_array(my_array, 5)  # This should trigger the IndexError
