namespace QFT
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    operation Set (desired: Result, q1: Qubit) : Unit
    {
        let current = M(q1);
        if (desired != current)
        {
            X(q1);
        }
    }

    operation QFT () : Unit
    {
        using (qs = Qubit[8])
        {
            for (i in 0..Length(qs) - 1)
            {
                let target = qs[Length(qs) - 1 - i];
                H(target);                              
                for (j in 0..Length(qs) - 2 - i) {
                    let control = qs[Length(qs) - 2 - i - j];
                    (Controlled R1)([control], (PI() / PowD(2.0, ToDouble(j + 1)), target));
                }
            }
            ResetAll(qs);
        }
    }
}
