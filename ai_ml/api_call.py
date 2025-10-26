import os
import json
import requests
import time
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("API_KEY")
API_URL = os.getenv("API_URL")
MODEL = os.getenv("MODEL_NAME")
INPUT_FILE = "test.txt"
OUTPUT_FILE = f"responses.json"


def read_questions_from_file(filename):
    with open(filename, "r", encoding="utf-8") as f:
        return [line.strip() for line in f if line.strip()]


def call_llm_api(prompt, max_retries=5):
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json",
    }

    payload = {
        "model": MODEL,
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": 250,
        "temperature": 0.7,
    }

    for attempt in range(max_retries):
        response = requests.post(API_URL, headers=headers, json=payload)

        if response.status_code == 200:
            data = response.json()
            return data["choices"][0]["message"]["content"].strip()

        #Handle Too Many Requests (429)
        elif response.status_code == 429:
            wait_time = (2 ** attempt) + 1 
            print(f"Rate limit hit. Waiting {wait_time}s before retry ({attempt+1}/{max_retries})...")
            time.sleep(wait_time)
        else:
            print(f"Error {response.status_code}: {response.text}")
            break

    return None


def save_responses_to_json(questions, responses, filename):
    output_data = [
        {"question": q, "response": r if r else "Error fetching response"}
        for q, r in zip(questions, responses)
    ]
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(output_data, f, indent=4, ensure_ascii=False)
    print(f"Responses saved to: {filename}")


def main():
    questions = read_questions_from_file(INPUT_FILE)
    print(f"Total questions found: {len(questions)}")
    responses = []

    for i, question in enumerate(questions, 1):
        print(f"\n Asking: {question}")
        answer = call_llm_api(question)
        responses.append(answer)
    save_responses_to_json(questions, responses, OUTPUT_FILE)


if __name__ == "__main__":
    main()
