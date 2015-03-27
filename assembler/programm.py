# Класс объекты которого необходимы для хранения данных о регистрах
class Register:
    def __init__ (self, num, name, adr):
        self.num = num # Номер регистра
        self.name = name # Имя регистра
        self.adr = adr # Адрес регистра


# Функция для чтения из файла данных о регистрах
# file_name - путь к файлу
def readRegisters(file_name):
    registers = [] # Задаем пустой список, в который добавим регистры
    reg_input = open(file_name, 'r')
    for line in reg_input: # Построчное считывания файла с помощью итератора
        line=line[:-1] # Удаляем символ перехода на новую строку
        reg_data = line.split(' ') # Получаем данные о регистре в виде 3х строк
        reg=Register(reg_data[0], reg_data[1], reg_data[2]) # Создаем новый
        # объект для хранения данных о регистре
        registers.append(reg) # Добавляем новый регистр в список

    return registers

file='registers.conf'
s = readRegisters(file)
for i in s:
    print(i.name)
