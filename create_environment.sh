#!/bin/bash

# Ask the user for their name
echo "Enter your name:"
read userName

# Create the main directory
mainDir="submission_reminder_${userName}"
mkdir -p "$mainDir/app"

# Create subdirectories
mkdir -p "$mainDir/modules"
mkdir -p "$mainDir/assets"
mkdir -p "$mainDir/config"

# Create and populate config.env
cat <<'EOF' > "$mainDir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create and populate functions.sh
cat <<'EOF' > "$mainDir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}

EOF

# Create and populate reminder.sh
cat <<'EOF' > "$mainDir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file

EOF

# Create and populate submissions.txt
cat <<'EOF' > "$mainDir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
John, Shell Navigation, not submitted
Jane, Git, submitted
Alice, Shell Navigation, not submitted
Bob, Shell Basics, submitted
Eve, Shell Navigation, not submitted
EOF

# Create and populate startup.sh
cat <<'EOF' > "$mainDir/startup.sh"
#!/bin/bash

# Start the reminder application
echo "Starting the Submission Reminder App..."
./app/reminder.sh
EOF

# Make scripts executable
chmod +x "$mainDir/app/reminder.sh"
chmod +x "$mainDir/startup.sh"
chmod +x "$mainDir/modules/functions.sh"

echo "Environment setup complete in directory: $mainDir"
