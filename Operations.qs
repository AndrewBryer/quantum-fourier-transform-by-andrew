namespace Shor
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    // Currently doesn't do Shor's algorithm but just calls the QFT
    operation Shor () : Unit
    {
        using (qs = Qubit[8])
        {
            QFT(qs);

            ResetAll(qs);
        }
    }

    // This takes in a register of Qubits in Big Endian format, that is, with the most significant bit in the position 0
    operation QFT (qs: Qubit[]) : Unit
    {
        for (i in 0..Length(qs) - 1)
        {
            let target = qs[i];
            H(target);                              
            for (j in i + 1..Length(qs) - 1) {
                let control = qs[j];
                (Controlled R1)([control], (PI() / PowD(2.0, ToDouble(j - i)), target));
            }
        }
    }
}
