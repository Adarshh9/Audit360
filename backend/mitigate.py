import json
import google.generativeai as genai
import re
import sys  # Import sys to access command-line arguments

# Configure the Google Generative AI client
genai.configure(api_key="AIzaSyAPupk9fLPpcp4m5Du7p49ewe3CRnkkqyo")
model_name = "gemini-1.5-flash"
model = genai.GenerativeModel(model_name)

def generate_text_from_file(filepath: str) -> str:
    try:
        # Read the JSON file
        with open(filepath, 'r') as file:
            data = json.load(file)

        prompt = 'Provide mitigation steps based on non compliance audit results: '
        data = f'{data[:3]}'  # Extract the first three items from the data
        print(data)
        
        # Generate text using the Google Generative AI model
        response = model.generate_content(prompt + data)
        response_text = response.text

        # Clean the response
        cleaned_text = re.sub(r"[\*]", "", response_text)

        return cleaned_text
    
    except Exception as e:
        return f"Error: {str(e)}"

def main(filepath: str):
    result = generate_text_from_file(filepath)
    
    # Save the result to result.txt
    with open("mitigation.txt", "w") as result_file:
        result_file.write(result)

    print("Result saved to mitigation.txt.")

# Example usage
if __name__ == "__main__":
    # Get the filepath from command line arguments
    if len(sys.argv) > 1:
        filepath = sys.argv[1]
        main(filepath)
    else:
        print("Please provide the file path as an argument.")