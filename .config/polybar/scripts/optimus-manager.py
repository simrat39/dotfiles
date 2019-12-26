import subprocess

def run(command):
    return subprocess.run(command,shell=True,capture_output=True)

a = run('optimus-manager --print-mode')

for gpu in ["nvidia","intel"]:
    if gpu in str(a):
        print(gpu)