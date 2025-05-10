#!/bin/bash
clear
output_file="search_results.txt"
echo -e "\t\t\tWelcome to the automated system of File and Folder Searching (FAFD)!"

while true; do
    read -r -p "Enter your choice (1.file, 2.folder): " choice

    if [[ $choice -eq 1 ]]; then
        read -r -p "Enter filename to search: " fname
        if [[ -n $fname ]]; then
            loc=$(find / -type f -iname "$fname" 2>/dev/null)
            if [[ -n $loc ]]; then
                {
                    echo "$fname file exists."
                    echo -e "At Location:\n$loc"
                    echo -e "\nGranted Permissions:"
                    while IFS= read -r filepath; do
                        ls -l "$filepath"
                    done <<<"$loc"
                    echo -e "\n--- End of Search ---\n"
                } | tee -a "$output_file"
                echo "Results saved in text file: $output_file"
            else
                echo "No file named '$fname' found." | tee -a "$output_file"
            fi
        else
            echo "No filename entered."
        fi

    elif [[ $choice -eq 2 ]]; then
        read -r -p "Enter folder name to search: " fold_name
        if [[ -n $fold_name ]]; then
            loc=$(find / -type d -iname "$fold_name" 2>/dev/null)
            if [[ -n $loc ]]; then
                {
                    echo "$fold_name folder exists."
                    echo -e "At Location:\n$loc"
                    echo -e "\nGranted Permissions:"
                    while IFS= read -r filepath; do
                        ls -ld "$filepath"
                    done <<<"$loc"
                    echo -e "\n--- End of Search ---\n"
                } | tee -a "$output_file"
                echo "Results saved in text file: $output_file"
            else
                echo "No folder named '$fold_name' found." | tee -a "$output_file"
            fi
        else
            echo "No folder name entered."
        fi

    else
        echo "Invalid choice! Please enter 1 or 2."
    fi
    while true; do
        read -r -p "Do you want to continue searching (Yes/No)? " answer
        answer=${answer^} # Capitalize first letter for comparison
        if [[ "$answer" == "Yes" ]]; then
            break # valid, continue outer loop
        elif [[ "$answer" == "No" ]]; then
            echo "Thanks for using automated system for File and Folder Searching (FAFD)"
            exit 0
        else
            echo "Please! answer in Yes or No."
        fi
    done
done