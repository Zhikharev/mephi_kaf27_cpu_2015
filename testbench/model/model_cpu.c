//model_cpu

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "func.h"

const int n_regs = 8;
const int m_regs = 3; 
uint32_t register_PC; // ������� ����������
uint32_t register_W; // ������� ��� �������� ����� ������ ��� ����� ��������
uint32_t register_K; // ������� ��� �������� ���������
uint32_t register_zero; // �������, ��������� �������� ����� ����
uint32_t register_LR; // ������� ��� �������� ������ �������� �� ������������
uint32_t register_MR; // ������� ��� ������ � �������
uint32_t register_hsum[n_regs]; // �������� ��� �������� ��������� ���-�����
uint32_t register_temp[m_regs]; // �������� ��� �������� ��������� ����������
uint32_t register_conf_cpu; // ������� ������������ ����������
uint16_t *memory; // ��������� �� ���

/*typedef uint32_t register_t; // ������ ���������
const int n_regs = 12; 
const int m_regs = 3; 
typedef struct {
register_t PC; // ������� ����������
register_t W; // ������� ��� �������� ����� ������ ��� ����� ��������register_K; // ������� ��� �������� ���������
register_t zero; // �������, ��������� �������� ����� ����
register_t LR; // ������� ��� �������� ������ �������� �� ������������
register_t MR; // ������� ��� ������ � �������
register_t hsum[n_regs]; // �������� ��� �������� ��������� ���-�����
register_t temp[m_regs]; // �������� ��� �������� ��������� ����������
register_t conf_cpu; // ������� ������������ ����������
uint16_t *memory; // ��������� �� ���
} state_t;*/


//������ ��������� ���� �� ������


//������������� ����������


//����������

switch (opcode) {
    case 0000: ... ; break;
    case 0001: ... ; break;
  
    ...

    default:         do_undefined; break;
}


//������ � ������


//PC