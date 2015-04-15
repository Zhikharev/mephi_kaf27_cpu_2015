import ctypes

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
    if num.startswith('0x'): # Проверяем на 16-ю систему счисления
        i = int(num, 16)
        i = bin(i)

    elif num.startswith('0b'): # Проверяем на 2-ю систему счисления
        i = int(num, 2)
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
def readRegisters(file_name):
    registers = [] # Задаем пустой список, в который добавим регистры
    reg_input = open(file_name, 'r')
    for line in reg_input: # Построчно считываем файл
        line=line[:-1] # Удаляем символ перехода на новую строку '\n'
        reg_data = line.split(' ') # Получаем данные о регистре в виде 3х строк
        reg=Register(reg_data[0], reg_data[1], reg_data[2]) # Создаем новый
        # объект для хранения данных о регистре
        registers.append(reg) # Добавляем новый регистр в список

    return registers

# Функция для нахождения адреса регистра по его номеру или имени
# передается имя или номер регистра и список всех регистров
def findRegisterAddress(registr, registers):
    for reg in registers: # Проверяем не является ли переданная строка
        if registr[1:] == reg.name: # Именем регистра
            return reg.addr # если является, то возвращаем адрес регистра
            break;

    for reg in registers:
        if registr[1:] == reg.num: # Номером регистра
            return reg.addr
            break;

    # Если переданная строка не является ни номером, ни именем регистра
    # То выводится сообщения об ошибке и программа останавливается
    error_string = 'Обнаружена ошибка при нахождении адреса регистра: ' + registr
    error_string += '. Регистр не обнаружен'
    ERROR(error_string)

# Функция формирования строки с адресами регистров
def getInstrAddrStr(reg_data, registers):
    result = findRegisterAddress(reg_data[1], registers)
    result += findRegisterAddress(reg_data[2], registers)
    result += findRegisterAddress(reg_data[0], registers)
    return result

# Функция пееревода инструкции Add в машинный код
# Передаётся строка инструкции и список регистров
def translateAddInstr(instruction, registers):
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
    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

# Функция пееревода инструкции Addi в машинный код
def translateAddiInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0001'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getNumStr(instruct_data[3], 4)
    result += findRegisterAddress(instruct_data[2], registers)
    result += findRegisterAddress(instruct_data[1], registers)
    return result

# Функция пееревода инструкции Or в машинный код
def translateOrInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0010'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

# Функция пееревода инструкции And в машинный код
def translateAndInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0011'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

def translateXorInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0100'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

def translateNorInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0101'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

def translateSllInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0110'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

def translateRotInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '0111'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

def translateBneInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '1000'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += getInstrAddrStr(instruct_data[1:], registers)
    return result

"""def translateJmpInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101100'
    result +=  getNumStr(instruct_data[1], 10)
    return result

def translateJalInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101101'
    result +=  getNumStr(instruct_data[1], 10)
    return result"""

def translateJrInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101110'
    result += '000000'
    result += findRegisterAddress(instruct_data[1], registers)
    return result

def translateJalrInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 2:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    result = '101111'
    result += '000000'
    result += findRegisterAddress(instruct_data[1], registers)
    return result

def translateNopInstr(instruction):
    instruct_data = instruction.split(" ")
    if len(instruct_data) == 1:
        result = '1100000000000000'

    elif len(instruct_data) == 2:
        num = int(instruct_data[1])
        result = '1100000000000000' * num

    else:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Неверное количество аргументов.'
        ERROR(error_string)

    return result


a = getNumStr('10', 6)
print(a)

rfile='registers.conf'
s = readRegisters(rfile)
print(translateNopInstr('NOP 3'))
