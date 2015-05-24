def addFlags(ifile, ofile):
    file = open(ifile, 'rb')
    text = file.read()
    file = open(ofile, 'wb')
    count = 0
    for char in text:
        if count == 0:
            file.write(bytes(chr(255), 'iso8859-1'))
            count += 2

        file.write(bytes(chr(int(char)), 'iso8859-1'))
        count -= 1

    file.write(bytes(chr(0), 'iso8859-1'))
