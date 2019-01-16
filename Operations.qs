namespace QFT
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    operation QFT () : Unit
    {
        using (qs = Qubit[8])
        {
            DoQFT(qs);
            
            // Do something

            ResetAll(qs);
        }
    }

    operation DoQFT (qs: Qubit[]) : Unit
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
