import ctypes
from struct import *
# Адресс файла с кодом на ассемблере
parsingFile = open("trycode.as", 'r')
# Файл разделенный на блоки директивами
fileByDirects = {}
# Метки и их адреса
label = {}
# Переменные объявленные в .set
variables = {}
# Ссылки на регистры
regLinks = {}
# Ссылки в память объявленные .data
dataLinks = {}
# Список, в который добавим регистры
registers = []
# Адрес в памяти на котором заканчивается память занимаемая программой
codeEndAddr = 0
dataEndAddr = 0
# Колличество байт на которое идет выравнивание
align = 2

data = ''
code = ''

# Класс который необходим для хранения данных о регистрах
class Register:
    def __init__ (self, num, name, addr):
        self.num = num # Номер регистра
        self.name = name # Имя регистра
        self.addr = addr # Адрес регистра

# Функция вывода ошибки
def ERROR (error_string):
    ctypes.windll.user32.MessageBoxW(0, error_string, 'Ошибка', 0)
    exit(0)

# Функция для перевода числа в двоичную систему счисления, с заданным
# количеством знаков
def getNumStr(num, length):
    i = 0
    if num.startswith('0X'): # Проверяем на 16-ю систему счисления
        i = int(num[2:], 16)
        i = bin(i)

    elif num.startswith('0B'): # Проверяем на 2-ю систему счисления
        i = int(num[2:], 2)
        i = bin(i)

    else: # Если не то не другое, значит 10-я система счисления
        i = int(num)
        i = bin(i)

    i = i[2:]
    if len(i) > length: # Проверка на превышения лимита
        ERROR("Ошибка при переводе числа " + num + ". Превышен лимит знаков")

    i = i.zfill(length)    # Дополнение нулями слева до необходимой длинны
    return i

# Функция для чтения из файла данных о регистрах
# file_name - путь к файлу
def readRegisters():
    global registers
    reg_input = open('registers.conf', 'r')
    for line in reg_input: # Построчно считываем файл
        line=line[:-1] # Удаляем символ перехода на новую строку '\n'
        reg_data = line.split(' ') # Получаем данные о регистре в виде 3х строк
        reg=Register(reg_data[0], reg_data[1], reg_data[2]) # Создаем новый
        # объект для хранения данных о регистре
        registers.append(reg) # Добавляем новый регистр в список

    print("Registers saved")

# Функция для нахождения адреса регистра по его номеру или имени
# передается имя или номер регистра и список всех регистров
def findRegisterAddress(registr):
    global registers
    if registr in regLinks:
        registr = regLinks[registr]

    for reg in registers: # Проверяем не является ли переданная строка
        if registr[1:] == reg.name: # Именем регистра
            return reg.addr # если является, то возвращаем адрес регистра
            break;

        if registr[1:] == reg.num: # Номером регистра
            return reg.addr
            break;

    # Если переданная строка не является ни номером, ни именем регистра
    # То выводится сообщения об ошибке и программа останавливается
    error_string = 'Обнаружена ошибка при нахождении адреса регистра: ' + registr
    error_string += '. Регистр не обнаружен'
    ERROR(error_string)

# Функция формирования строки с адресами регистров
def getInstrAddrStr(reg_data):
    result = findRegisterAddress(reg_data[1])
    result += findRegisterAddress(reg_data[2])
    result += findRegisterAddress(reg_data[0])
    return result

# Функция пееревода инструкции Add в машинный код
# Передаётся строка инструкции
def translateAddInstr(instruction):
    instruct_data = instruction.split(" ") # Разделяем инструкцию по пробелам
    if len(instruct_data) != 4: # Проверка количества аргументов в инструкции
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    # Записываем в строку код команды Add
    result = '0000'
    for i in range(1, 3): # Удаляем запятые после регистров
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    # Формируем конечный двоичный код инструкции
    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateAddiInstr(instruction):
    global variables
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0001'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    if instruct_data[3] in variables:
        result += getNumStr(str(variables[instruct_data[3]]), 4)

    else:
        result += getNumStr(instruct_data[3], 4)

    result += findRegisterAddress(instruct_data[2])
    result += findRegisterAddress(instruct_data[1])
    return result

def translateOrInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0010'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateAndInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0011'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateXorInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0100'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateNorInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0101'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateSllInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0110'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateRotInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0111'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateBneInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '1000'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:])
    return result

def translateLdInstr(instruction):
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '100100'
    addr = getNumStr(instruct_data[1], 10)
    result += addr
    result += '100110'
    addr = getNumStr(str(int(addr, 2) + align), 10)
    result += addr
    return result

def translateStInstr(instruction):
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101000'
    addr = getNumStr(instruct_data[1], 10)
    result += addr
    result += '101010'
    addr = getNumStr(str(int(addr, 2) + align), 10)
    result += addr
    return result

def translateJmpInstr(instruction):
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101100'
    addr = label[instruct_data[1]]
    addr = getNumStr(str(addr), 10)
    result += addr
    return result

def translateJalInstr(instruction):
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101101'
    addr = label[instruct_data[1]]
    addr = getNumStr(str(addr), 10)
    result += addr
    return result

def translateJrInstr(instruction):
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101110'
    result += '00' + findRegisterAddress(instruct_data[1]) + '0000'
    return result

def translateJalrInstr(instruction):
    instruct_data = instruction.split(' ')
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101111'
    result += '00' + findRegisterAddress(instruct_data[1]) + '0000'
    return result

def translateNopInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) == 1:
        result = '1100000000000000'

    elif len(instruct_data) == 2:
        num = int(instruct_data[1][1:-1])
        result = '1100000000000000' * num

    else:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    return result

# Функция для разделения файла на блоки по директивам
def setDirectivesList():
    global parsingFile
    global fileByDirects
    current = ''
    for line in parsingFile:
        if '#' in line: # Удаление комментария в строке
            line = line[:line.find('#')] + '\n'

        line = line.strip() + '\n' # Удаление пробельных символов слева и справа
        if line.startswith('.'): # Нахождение директив
            # Обработка .text и .data
            if line.startswith('.text') or line.startswith('.data'):
                current = line.strip()
                # Директивы могут встречаться в файле несколько раз
                if current not in fileByDirects:
                    fileByDirects[current] = ''

                continue;

            elif line.startswith('.set') or line.startswith('.def'):
                if len(line) == 5:
                    current = line.strip()
                    if current not in fileByDirects:
                        fileByDirects[current] = ''

                elif len(line.split(' ')) == 3:
                    current = line[:4]
                    if current not in fileByDirects:
                        fileByDirects[current] = line[4:].lstrip()

                    else:
                        fileByDirects[current] += line[4:].lstrip()

        else:
            if current != '':
                if len(line) > 1:
                    fileByDirects[current] += line

            elif len(line) > 1:
                current = '.none'
                fileByDirects[current] = line

# Функция обработки директивы .data
def parseDataLines():
    global codeEndAddr
    global fileByDirects
    global dataEndAddr
    global data
    global align
    global dataLinks
    dataEndAddr = codeEndAddr + 2
    if '.data' in fileByDirects:
        dataLines = fileByDirects['.data'].splitlines()
        for line in dataLines:
            line = line.split(' ')
            line = [l.strip() for l in line]
            if len(line) == 2:
                data += getNumStr(line[1].upper(), align * 8)
                dataLinks[line[0].upper()] = dataEndAddr
                dataEndAddr += align

            else:
                error_string = 'Ошибка в блоке .data'
                ERROR(error_string)

    else:
        print('.data not included in fileByDirectives')

def parseTextLines():
    global label
    global codeEndAddr
    global code
    if '.text' in fileByDirects:
        codeLines = fileByDirects['.text'].splitlines()
        if '.none' in fileByDirects:
            codeLines = fileByDirects['.none'].splitlines() + codeLines

    elif '.none' in fileByDirects:
        codeLines = fileByDirects['.none'].splitlines()

    else:
        error_string = 'Код не найден.'
        ERROR(error_string)

    count = 0
    for line in codeLines:
        if ':' in line: # Метка
            line = line.split(':')
            # Условие если метка на отдельной строке
            if len(line)==2 and line[1] == '' :
                label[line[0].upper()] = codeEndAddr
                # Удаляет строку с назаванием метки
                codeLines = codeLines[:count] + codeLines[count + 1:]
                continue;
            # Если после метки идет код
            elif len(line) == 2 and line[1] != '':
                label[line[0]] = codeEndAddr
                line = line[1]
                if line.upper().startswith('LD') or line.upper().startswith('ST'):
                    codeEndAddr += 2

                elif line.upper().startswith('NOP') and len(line.split(' ')) == 2:
                    line = line.split(' ')
                    num = int(line[1][1:-1])
                    codeEndAddr += (num - 1)*2

                codeEndAddr += 2
                codeLines[count] = line.strip() + '\n'
                continue;

            # Если встроке встретилось более одного знака ":"
            else:
                error_string = ' В строке:'
                error_string += ' В одной строке может быть только одна метка.'
                ERROR(error_string)

        else:
            if line.upper().startswith('LD') or line.upper().startswith('ST'):
                codeEndAddr += 2

            elif line.upper().startswith('NOP') and len(line.split(' ')) == 2:
                line = line.split(' ')
                num = int(line[1][1:-1])
                codeEndAddr += (num - 1)*2

            codeEndAddr += 2

        count += 1

    parseDataLines()
    for line in codeLines:
        line = line.upper()
        if line.split(' ')[0] == 'ADD':
            code += translateAddInstr(line)

        elif line.startswith('ADDI'):
            code += translateAddiInstr(line)

        elif line.startswith('OR'):
            code += translateOrInstr(line)

        elif line.startswith('AND'):
            code += translateAndInstr(line)

        elif line.startswith('XOR'):
            code += translateXorInstr(line)

        elif line.startswith('NOR'):
            code += translateNorInstr(line)

        elif line.startswith('SLL'):
            code += translateSllInstr(line)

        elif line.startswith('ROT'):
            code += translateRotInstr(line)

        elif line.startswith('BNE'):
            code += translateBneInstr(line)

        elif line.startswith('LD'):
            code += translateLdInstr(line)

        elif line.startswith('ST'):
            code += translateStInstr(line)

        elif line.startswith('JMP'):
            code += translateJmpInstr(line)

        elif line.startswith('JAL'):
            code += translateJalInstr(line)

        elif line.startswith('JR'):
            code += translateJrInstr(line)

        elif line.startswith('JALR'):
            code += translateJalrInstr(line)

        elif line.startswith('NOP'):
            code += translateNopInstr(line)

        else:
            ERROR('Инструкция не найдена. Ошибка в строке: ' + line)


def parseSetLines():
    global fileByDirectives
    global variables
    if '.set' in fileByDirects:
        setLines = fileByDirects['.set'].splitlines()
        for line in setLines:
            line = line.upper()
            if len(line) > 0:
                line = line.split(' ')
                if len(line) == 2:
                    variables[line[0]] = int(line[1])

                else:
                    ERROR('Ошибка в блоке .set')

    else:
        print('.set not included in fileByDirectives')

def parseDefLines():
    global fileByDirects
    global regLinks
    if '.def' in fileByDirects:
        defLines = fileByDirects['.def'].splitlines()
        for line in defLines:
            line = line.upper()
            if len(line) > 0:
                line = line.split(' ')
                if len(line) == 2:
                    regLinks[line[0]] = (line[1])

                else:
                    ERROR('Ошибка в блоке .def')
    else:
        print('.def not included in fileByDirectives')

def parseFile():
    readRegisters()
    setDirectivesList()
    parseSetLines()
    parseDefLines()
    parseTextLines()

parseFile()
print(code)


'''file = open('file.bin','wb')

d = pack(str(len(code))+'s', bytes(code, 'UTF-8'))
file.write(d)'''

file = open('file.bin','wb')
cur = 0
while cur < len(code):
    d = pack('>I', int(code[cur:cur+4],2))
    file.write(d)
    cur+=4
