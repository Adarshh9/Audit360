import time
import sys

def main():
    print("Running file1.py")
    time.sleep(1)  # Simulate some processing time
    
    # Loop to print "Vighnesh"
    for _ in range(5):  # Change the range as needed
        print("Vighnesh")
        time.sleep(1)  # Optional: Add delay for visibility
    
    print("file1.py completed")
    
    # Return True to indicate success
    return True

if __name__ == "__main__":
    success = main()
    # Exit with code 0 if successful, otherwise a non-zero code
    sys.exit(0 if success else 1)
