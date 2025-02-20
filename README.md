# submission_reminder_app_kylealu
Setup:
Run create_environment.sh, which asks for your name and creates a directory (submission_reminder_{name}/app).
Populates subdirectories (config, modules, assets) with files:
config.env: Sets the assignment (Shell Navigation) and deadline (2 days).
submissions.txt: Lists students, assignments, and submission statuses.
functions.sh: Contains logic to check unsubmitted assignments.
reminder.sh: Main script that triggers reminders.
startup.sh: Entry point to launch the app.

Execution:
Running startup.sh calls reminder.sh, which sources config.env and functions.sh.
The check_submissions function reads submissions.txt, skips the header, and loops through entries.

Logic:
For each student, it trims whitespace and checks:
If their assignment matches Shell Navigation.
If their status is not submitted.
If both conditions are met, it prints a reminder (e.g., “Reminder: Alice has not submitted…”).
Edit submissions.txt to add more students (follow the CSV format).

Modify config.env to change assignments/deadlines.
