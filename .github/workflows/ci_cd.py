import os
import subprocess

# Environment variables
TEST_VALUE = os.getenv("TEST_VALUE")
GH_PAT = os.getenv("GH_PAT")

# Step 1: Clone repository and copy file
def clone_repository():
    print("Cloning repository...")
    subprocess.run(["git", "clone", "--depth", "1", "https://github.com/matejnovak29/testingrepository2.git"], check=True)
    subprocess.run(["cp", "testingrepository2/print.py", "."], check=True)

# Step 2: Run Python script
def run_script():
    print("Running script...")
    subprocess.run(["python", "print.py"], check=True)

# Step 3: Commit changes
def commit_changes():
    print("Committing changes...")
    subprocess.run(["git", "checkout", "-b", "new-feature-branch"], check=True)
    subprocess.run(["git", "add", "print.py"], check=True)
    subprocess.run(["git", "commit", "-m", "Add print.py from testingrepository2"], check=True)
    subprocess.run(["git", "push", "origin", "new-feature-branch"], check=True)

# Step 4: Create pull request
def create_pull_request():
    print("Creating pull request...")
    subprocess.run(
        [
            "gh", "pr", "create",
            "--title", "Add print.py from testingrepository2",
            "--body", "This PR adds the print.py file from testingrepository2.",
            "--base", "main",
            "--head", "new-feature-branch"
        ],
        check=True,
        env={"GH_TOKEN": GH_PAT}
    )

if __name__ == "__main__":
    clone_repository()
    run_script()
    commit_changes()
    create_pull_request()
