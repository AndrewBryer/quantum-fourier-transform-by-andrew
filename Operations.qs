namespace FindPeriod
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    // Currently doesn't find period but just calls the adjoint QFT
    operation FindPeriod () : Unit
    {
        using (qs = Qubit[8])
        {
            ApplyToEach(H, qs);

            // Apply the function f to the register qs and put that result in some other register that needs to be initialised

            Adjoint QFT(qs);

            ResetAll(qs);
        }
    }

    operation QFT (qs: Qubit[]) : Unit
    {
        body (...) 
        {
            for (i in 0..Length(qs) - 1)
            {
                let target = qs[i];
                H(target);                              
                for (j in i + 1..Length(qs) - 1) {
                    let control = qs[j];
                    Controlled R1([control], (PI() / PowD(2.0, ToDouble(j - i)), target));
                }
            }
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }
}
