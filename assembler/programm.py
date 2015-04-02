import ctypes

# Класс который необходим для хранения данных о регистрах
class Register:
    def __init__ (self, num, name, addr):
        self.num = num # Номер регистра
        self.name = name # Имя регистра
        self.addr = addr # Адрес регистра


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
    ctypes.windll.user32.MessageBoxW(0, error_string, 'Ошибка', 0)
    exit(0)

# Функция пееревода инструкции Add в машинный код
# Передаётся строка инструкции и список регистров
def translateAddInstr(instruction, registers):
    instruct_data = instruction.split(" ") # Разделяем инструкцию по пробелам
    if len(instruct_data) != 4: # Проверка количества аргументов в инструкции
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Недостаточно аргументов.'
        ctypes.windll.user32.MessageBoxW(0, error_string, 'Ошибка', 0)
        exit(0)

    # Записываем в строку код команды Add
    result = '0000'
    for i in range(1, 3): # Удаляем запятые после регистров
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    # Формируем конечный двоичный код инструкции
    result += findRegisterAddress(instruct_data[2], registers)
    result += findRegisterAddress(instruct_data[3], registers)
    result += findRegisterAddress(instruct_data[1], registers)
    return result

# Функция пееревода инструкции Or в машинный код
def translateOrInstr(instruction, registers):
    instruct_data = instruction.split(" ")
    if len(instruct_data) != 4:
        error_string = 'Обнаружена ошибка при переводе строки: ' + instruction
        error_string += '. Недостаточно аргументов.'
        ctypes.windll.user32.MessageBoxW(0, error_string, 'Ошибка', 0)
        exit(0)

    result = '0010'
    for i in range(1, 3):
        if (instruct_data[i].endswith(',')):
            instruct_data[i] = instruct_data[i][:-1]

    result += findRegisterAddress(instruct_data[2], registers)
    result += findRegisterAddress(instruct_data[3], registers)
    result += findRegisterAddress(instruct_data[1], registers)
    return result

rfile='registers.conf'
s = readRegisters(rfile)
print(translateOrInstr("Or $0, $1, $2", s))
