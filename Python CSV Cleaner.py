#Python cleaner script

input_file = "C:/Users/mjako/OneDrive/Desktop/Cleaned_ITINERARIES.CSV"
output_file = "C:/Users/mjako/OneDrive/Desktop/CI2.CSV"

with open(input_file, "r", encoding="utf-8") as infile, open(output_file, "w", encoding="utf-8") as outfile:
    for i, line in enumerate(infile):
        columns = line.strip().split(",")  

        # Remove extra values after || in every column
        columns = [col.split("||")[0] for col in columns]

        outfile.write(",".join(columns) + "\n")  

        if i % 1_000_000 == 0:
            print(f"Processed {i} lines...")

print("Finished processing!")
