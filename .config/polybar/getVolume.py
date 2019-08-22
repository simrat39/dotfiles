import subprocess
output = subprocess.check_output("amixer get Master", shell=True)

uh = []
omit_list = [" "]
volume=""

for everything in str(output):
    if everything not in omit_list:
        uh.append(everything)

for element in uh:
    if element == "%":
        if str(uh[uh.index(element)-3]).isdigit():
           volume+=str(uh[uh.index(element)-3])

        if str(uh[uh.index(element)-2]) != "[":
           volume+=str(uh[uh.index(element)-2])

        volume += str(uh[uh.index(element)-1])
        break
print(volume+"%")
