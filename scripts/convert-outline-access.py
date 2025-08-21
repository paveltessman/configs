try:
    print()
    cert_line = input("Paste lines from /opt/outline/access.txt here:\n\n")
    apiurl_line = input()

    cert = cert_line.split(":", 1)
    apiurl = apiurl_line.split(":", 1)

    print(f"""\n    {{"{cert[0]}":"{cert[1]}","{apiurl[0]}":"{apiurl[1]}"}}\n""")
          
except KeyboardInterrupt:
    exit()

