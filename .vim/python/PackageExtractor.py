import vim
import re

def main():
    file = open("AndroidManifest.xml")

    if file == None:
        vim.command("let result=''")
        return

    package = ""
    line = file.readline()
    while line != "":
        m = re.search("package=\"(.*)\"", line)
        if m != None:
            r = m.group(1)
            vim.command("let result='%s'" % r)
            return
        line = file.readline()

    vim.command("let result=''")

main()

