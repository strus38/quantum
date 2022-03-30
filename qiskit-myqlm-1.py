#!/usr/bin/env python3

from qiskit import *
from qiskit.tools.monitor import job_monitor
from qat.interop.qiskit import qiskit_to_qlm
from qat.pylinalg import PyLinalg

import turtle
from turtle import *
import math


qr = QuantumRegister(6)
cr = ClassicalRegister(6)

circuit=QuantumCircuit(qr,cr)
circuit.h(qr[0])
circuit.h(qr[1])
circuit.h(qr[2])
circuit.h(qr[3])
circuit.h(qr[4])
circuit.h(qr[5])

circuit.cx(qr[0],qr[1])
circuit.measure(qr,cr)

qlm_circuit = qiskit_to_qlm(circuit)

qlm_job = qlm_circuit.to_job()
qlm_qpu = PyLinalg() # or any other QPU you would like to raise
qlm_result = qlm_qpu.submit(qlm_job)

bin=qlm_result[0].state

print(str(bin)[1:-1])
dec=int(str(bin)[1:-1], base=2)
print(dec)

nft=turtle.Turtle()
nft.color("blue")
nft.speed(10)
title("Quantum demo")

for i in range((dec+1)*30):
    nft.forward(math.sqrt(i)*20)
    nft.left(dec*10)
    nft.right(dec/2)

turtle.done
