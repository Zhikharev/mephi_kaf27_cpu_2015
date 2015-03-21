//model_cpu

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "func.h"

const int n_regs = 8;
const int m_regs = 3; 
uint32_t register_PC; // счётчик инструкций
uint32_t register_W; // регистр для хранения слова данных для одной итерации
uint32_t register_K; // регистр для хранения константы
uint32_t register_zero; // регистр, аппаратно хранящий число ноль
uint32_t register_LR; // регистр для хранения адреса возврата из подпрограммы
uint32_t register_MR; // регистр для работы с памятью
uint32_t register_hsum[n_regs]; // регистры для хранения состояний хеш-суммы
uint32_t register_temp[m_regs]; // регистры для хранения временных переменных
uint32_t register_conf_cpu; // регистр конфигурации процессора
uint16_t *memory; // указатель на ОЗУ

/*typedef uint32_t register_t; // ширина регистров
const int n_regs = 12; 
const int m_regs = 3; 
typedef struct {
register_t PC; // счётчик инструкций
register_t W; // регистр для хранения слова данных для одной итерацииregister_K; // регистр для хранения константы
register_t zero; // регистр, аппаратно хранящий число ноль
register_t LR; // регистр для хранения адреса возврата из подпрограммы
register_t MR; // регистр для работы с памятью
register_t hsum[n_regs]; // регистры для хранения состояний хеш-суммы
register_t temp[m_regs]; // регистры для хранения временных переменных
register_t conf_cpu; // регистр конфигурации процессора
uint16_t *memory; // указатель на ОЗУ
} state_t;*/


//чтение машинного кода из памяти


//декодирование инструкции


//исполнение

switch (opcode) {
    case 0000: ... ; break;
    case 0001: ... ; break;
  
    ...

    default:         do_undefined; break;
}


//запись в память


//PC