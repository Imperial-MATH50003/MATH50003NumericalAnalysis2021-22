# MATH50003 Numerical Analysis Lecture Notes

**Author: Dr. Sheehan Olver    |    <img src="https://cdn.iconscout.com/icon/free/png-128/github-logo-3002017-2496133.png" alt="Github Logo Icon" style="zoom:25%;" />   [<u>Github Source</u>](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis)**

[toc]

## Asymptotics and Computational Cost
>**YouTube Lectures:**
>[Asymptotics and Computational Cost](https://www.youtube.com/watch?v=xh03nnHrpBc)

We introduce Big-O, little-o and asymptotic notation and see
how they can be used to describe computational cost.

1. Asymptotics as $n → ∞$
2. Asymptotics as $x → x_0$
3. Computational cost

### 1. Asymptotics as $n → ∞$

Big-O, little-o, and "asymptotic to" are used to describe behaviour of functions
at infinity. 

>**Definition (Big-O)** 
>$$
>f(n) = O(ϕ(n)) \qquad \hbox{(as $n → ∞$)}
>$$
>means
>$$
>\left|{f(n) \over ϕ(n)}\right|
>$$
>is bounded for sufficiently large $n$. That is,
>there exist constants $C$ and $N_0$ such 
>that, for all $n \geq N_0$, $|{f(n) \over ϕ(n)}| \leq C$.

>**Definition (little-O)** 
>$$
>f(n) = o(ϕ(n)) \qquad \hbox{(as $n → ∞$)}
>$$
>means
>$$
>\lim_{n → ∞} {f(n) \over ϕ(n)} = 0.
>$$

>**Definition (asymptotic to)** 
>$$
>f(n) ∼ ϕ(n) \qquad \hbox{(as $n → ∞$)}
>$$
>means
>$$
>\lim_{n → ∞} {f(n) \over ϕ(n)} = 1.
>$$

**<span style="color:#008080">Example</span> (integer in binary)**
$$
{\cos n \over n^2 -1} = O(n^{-2})
$$
as
$$
\left|{{\cos n \over n^2 -1} \over n^{-2}} \right| \leq \left| n^2 \over n^2 -1 \right|  \leq 2
$$
for $n \geq N_0 = 2$.
$$
\log n = o(n)
$$
as
$$
lim_{n → ∞} {\log n \over n} = 0.
$$
$$
n^2 + 1 ∼ n^2
$$
as
$$
{n^2 +1 \over n^2} → 1.
$$


Note we sometimes write $f(O(ϕ(n)))$ for a function of the form $f(g(n))$ such that $g(n) = O(ϕ(n))$.

#### Rules

We have some simple algebraic rules:

>**Proposition (Big-O rules)**
>$$
>\begin{align*}
>O(ϕ(n))O(ψ(n)) = O(ϕ(n)ψ(n))  \qquad \hbox{(as $n → ∞$)} \\
>O(ϕ(n)) + O(ψ(n)) = O(|ϕ(n)| + |ψ(n)|)  \qquad \hbox{(as $n → ∞$)}.
>\end{align*}
>$$


### 2. Asymptotics as $x → x_0$

We also have Big-O, little-o and "asymptotic to" at a point:

>**Definition (Big-O)** 
>$$
>f(x) = O(ϕ(x)) \qquad \hbox{(as $x → x_0$)}
>$$
>means
>$$
>|f(x) \over ϕ(x)|
>$$
>is bounded in a neighbourhood of $x_0$. That is,
>there exist constants $C$ and $r$ such 
>that, for all $0 \leq |x - x_0| \leq r$, $|{f(x) \over ϕ(x)}| \leq C$.

>**Definition (little-O)** 
>$$
>f(x) = o(ϕ(x)) \qquad \hbox{(as $x → x_0$)}
>$$
>means
>$$
>\lim_{x → x_0} {f(x) \over ϕ(x)} = 0.
>$$

>**Definition (asymptotic to)** 
>$$
>f(x) ∼ ϕ(x) \qquad \hbox{(as $x → x_0$)}
>$$
>means
>$$
>\lim_{x → x_0} {f(x) \over ϕ(x)} = 1.
>$$

**<span style="color:#008080">Example</span> (integer in binary)**
$$
\exp x = 1 + x + O(x^2) \qquad \hbox{as $x → 0$}
$$
Since
$$
\exp x = 1 + x + {\exp t \over 2} x^2
$$
for some $t \in [0,x]$ and
$$
\left|{{\exp t \over 2} x^2 \over x^2}\right| \leq {3 \over 2}
$$
provided $x \leq 1$.


### 3. Computational cost

We will use Big-O notation to describe the computational cost of algorithms.
Consider the following simple sum
$$
\sum_{k=1}^n x_k^2
$$
which we might implement as:
```julia
function sumsq(x)
    n = length(x)
    ret = 0.0
    for k = 1:n
        ret = ret + x[k]^2
    end
    ret
end

n = 100
x = randn(n)
sumsq(x)
```
Each step of this algorithm consists of one memory look-up (`z = x[k]`),
one multiplication (`w = z*z`) and one addition (`ret = ret + w`).
We will ignore the memory look-up in the following discussion.
The number of CPU operations per step is therefore 2 (the addition and multiplication).
Thus the total number of CPU operations is $2n$. But the constant $2$ here is
misleading: we didn't count the memory look-up, thus it is more sensible to
just talk about the asymptotic complexity, that is, the _computational cost_ is $O(n)$.

Now consider a double sum like:
$$
\sum_{k=1}^n \sum_{j=1}^k x_j^2
$$
which we might implement as:
```julia
function sumsq2(x)
    n = length(x)
    ret = 0.0
    for k = 1:n
        for j = 1:k
            ret = ret + x[j]^2
        end
    end
    ret
end

n = 100
x = randn(n)
sumsq2(x)
```

Now the inner loop is $O(1)$ operations (we don't try to count the precise number),
which we do $k$ times for $O(k)$ operations as $k → ∞$. The outer loop therefore takes
$$
∑_{k = 1}^n O(k) = O\left(∑_{k = 1}^n k\right) = O\left( {n (n+1) \over 2} \right) = O(n^2)
$$
operations.

## Numbers
>**YouTube Lectures:**
>[Integers](https://www.youtube.com/watch?v=xSBXaKfSZsA&feature=youtu.be)
>[Floating Point Numbers](https://www.youtube.com/watch?v=0KPsii4vzsM)
>[Rounding](https://www.youtube.com/watch?v=xXaNAmyMddU)
>[Bouding Rounding Errors](https://www.youtube.com/watch?v=C-sG9EBFsDQ)

Reference: [Overton](https://cs.nyu.edu/~overton/book/)

In this chapter, we introduce the [Two's-complement](https://en.wikipedia.org/wiki/Two's_complement)
storage for integers and the 
[IEEE Standard for Floating-Point Arithmetic](https://en.wikipedia.org/wiki/IEEE_754).
There are many  possible ways of representing real numbers on a computer, as well as 
the precise behaviour of operations such as addition, multiplication, etc.
Before the 1980s each processor had potentially a different representation for 
real numbers, as well as different behaviour for operations.  
IEEE introduced in 1985 was a means to standardise this across
processors so that algorithms would produce consistent and reliable results.

This chapter may seem very low level for a mathematics course but there are
two important reasons to understand the behaviour of integers and floating-point numbers:

1. Integer arithmetic can suddenly start giving wrong negative answers when numbers
become large.
2. Floating-point arithmetic is very precisely defined, and can even be used
in rigorous computations as we shall see in the problem sheets. But it is not exact
and its important to understand how errors in computations can accumulate.
3. Failure to understand floating-point arithmetic can cause catastrophic issues
in practice, with the extreme example being the 
[explosion of the Ariane 5 rocket](https://youtu.be/N6PWATvLQCY?t=86).


In this chapter we discuss the following:

1. Binary representation: Any real number can be represented in binary, that is,
by an infinite sequence of 0s and 1s (bits). We review  binary representation.
2. Integers:  There are multiple ways of representing integers on a computer. We discuss the 
the different types of integers and their representation as bits, and how arithmetic operations behave 
like modular arithmetic. As an advanced topic we discuss `BigInt`, which uses variable bit length storage.
2. Floating-point numbers: Real numbers are stored on a computer with a finite number of bits. 
There are three types of floating-point numbers: _normal numbers_, _subnormal numbers_, and _special numbers_.
3. Arithmetic: Arithmetic operations in floating-point are exact up to rounding, and how the
rounding mode can be set. This allows us to bound  errors computations.
4. High-precision floating-point numbers: As an advanced topic, we discuss how the precision of floating-point arithmetic can be increased arbitrary
using `BigFloat`. 

Before we begin, we load two external packages. SetRounding.jl allows us 
to set the rounding mode of floating-point arithmetic. ColorBitstring.jl
  implements functions `printbits` (and `printlnbits`)
which print the bits (and with a newline) of floating-point numbers in colour.
```julia
using SetRounding, ColorBitstring
```



### 1.  Binary representation

Any integer can be presented in binary format, that is, a sequence of `0`s and `1`s.

> **Definition**
> For $B_0,\ldots,B_p \in \{0,1\}$ denote a non-negative integer in _binary format_ by:
> $$
> (B_p\ldots B_1B_0)_2 := 2^pB_p + \cdots + 2B_1 + B_0
> $$
> For $b_1,b_2,\ldots \in \{0,1\}$, Denote a non-negative real number in _binary format_ by:
> $$
> (B_p \ldots B_0.b_1b_2b_3\ldots)_2 = (B_p \ldots B_0)_2 + {b_1 \over 2} + {b_2 \over 2^2} + {b_3 \over 2^3} + \cdots
> $$
> 



First we show some examples of verifying a numbers binary representation:

**<span style="color:#008080">Example</span> (integer in binary)**
A simple integer example is $5 = 2^2 + 2^0 = (101)_2$.

**<span style="color:#008080">Example</span> (rational in binary)**
Consider the number `1/3`.  In decimal recall that:
$$
1/3 = 0.3333\ldots =  \sum_{k=1}^\infty {3 \over 10^k}
$$
We will see that in binary
$$
1/3 = (0.010101\ldots)_2 = \sum_{k=1}^\infty {1 \over 2^{2k}}
$$
Both results can be proven using the geometric series:
$$
\sum_{k=0}^\infty z^k = {1 \over 1 - z}
$$
provided $|z| < 1$. That is, with $z = {1 \over 4}$ we verify the binary expansion:
$$
\sum_{k=1}^\infty {1 \over 4^k} = {1 \over 1 - 1/4} - 1 = {1 \over 3}
$$
A similar argument with $z = 1/10$ shows the decimal case.

### 2. Integers


On a computer one typically represents integers by a finite number of $p$ bits,
with $2^p$ possible combinations of 0s and 1s. For _unsigned integers_ (non-negative integers) 
these bits are just the first $p$ binary digits: $(B_{p-1}\ldots B_1B_0)_2$.

Integers on a computer follow [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic):

> **Definition (ring of integers modulo $m$)** Denote the ring
> $$
> {\mathbb Z}_{m} := \{0 \ ({\rm mod}\ m), 1 \ ({\rm mod}\ m), \ldots, m-1 \ ({\rm mod}\ m) \}
> $$
> 

Integers represented with $p$-bits on a computer actually represent elements of ${\mathbb Z}_{2^p}$ and integer arithmetic on a computer is 
equivalent to arithmetic modulo $2^p$.

**<span style="color:#008080">Example</span> (addition of 8-bit unsigned integers)** Consider the addition of
two 8-bit numbers:
$$
255 + 1 = (11111111)_2 + (00000001)_2 = (100000000)_2 = 256
$$
The result is impossible to store in just 8-bits! It is way too slow
for a computer to increase the number of bits, or to throw an error (checks are slow).
So instead it treats the integers as elements of ${\mathbb Z}_{256}$:
$$
255 + 1 \ ({\rm mod}\ 256) = (00000000)_2 \ ({\rm mod}\ 256) = 0 \ ({\rm mod}\ 256)
$$
We can see this in Julia:
```julia
x = UInt8(255)
y = UInt8(1)
printbits(x); println(" + "); printbits(y); println(" = ")
printbits(x + y)
```


**<span style="color:#008080">Example</span> (multiplication of 8-bit unsigned integers)** 
Multiplication works similarly: for example,
$$
254 * 2 \ ({\rm mod}\ 256) = 252 \ ({\rm mod}\ 256) = (11111100)_2 \ ({\rm mod}\ 256)
$$
We can see this behaviour in code by printing the bits:
```julia
x = UInt8(254) # 254 represented in 8-bits as an unsigned integer
y = UInt8(2)   #   2 represented in 8-bits as an unsigned integer
printbits(x); println(" * "); printbits(y); println(" = ")
printbits(x * y)
```

#### Signed integer

Signed integers use the [Two's complemement](https://epubs.siam.org/doi/abs/10.1137/1.9780898718072.ch3)
convention. The convention is if the first bit is 1 then the number is negative: the number $2^p - y$
is interpreted as $-y$.
Thus for $p = 8$ we are interpreting
$2^7$ through $2^8-1$ as negative numbers. 

**<span style="color:#008080">Example</span> (converting bits to signed integers)** 
What 8-bit integer has the bits `01001001`? Adding the corresponding decimal places we get:
```julia
2^0 + 2^3 + 2^6
```
What 8-bit (signed) integer has the bits `11001001`? Because the first bit is `1` we know it's a negative 
number, hence we need to sum the bits but then subtract `2^p`:
```julia
2^0 + 2^3 + 2^6 + 2^7 - 2^8
```
We can check the results using `printbits`:
```julia
printlnbits(Int8(73))
printbits(-Int8(55))
```

Arithmetic works precisely
the same for signed and unsigned integers.

**<span style="color:#008080">Example</span> (addition of 8-bit integers)**
Consider `(-1) + 1` in 8-bit arithmetic. The number $-1$ has the same bits as
$2^8 - 1 = 255$. Thus this is equivalent to the previous question and we get the correct
result of `0`. In other words:
$$
-1 + 1 \ ({\rm mod}\ 2^p) = 2^p-1  + 1 \ ({\rm mod}\ 2^p) = 2^p \ ({\rm mod}\ 2^p) = 0 \ ({\rm mod}\ 2^p)
$$


**<span style="color:#008080">Example</span> (multiplication of 8-bit integers)**
Consider `(-2) * 2`. $-2$ has the same bits as $2^{256} - 2 = 254$ and $-4$ has the
same bits as $2^{256}-4 = 252$, and hence from the previous example we get the correct result of `-4`.
In other words:
$$
(-2) * 2 \ ({\rm mod}\ 2^p) = (2^p-2) * 2 \ ({\rm mod}\ 2^p) = 2^{p+1}-4 \ ({\rm mod}\ 2^p) = -4 \ ({\rm mod}\ 2^p)
$$





**<span style="color:#008080">Example</span> (overflow)** We can find the largest and smallest instances of a type using `typemax` and `typemin`:
```julia
printlnbits(typemax(Int8)) # 2^7-1 = 127
printbits(typemin(Int8)) # -2^7 = -128
```
As explained, due to modular arithmetic, when we add `1` to the largest 8-bit integer we get the smallest:
```julia
typemax(Int8) + Int8(1) # returns typemin(Int8)
```
This behaviour is often not desired and is known as _overflow_, and one must be wary
of using integers close to their largest value.


#### Variable bit representation (**advanced**)

An alternative representation for integers uses a variable number of bits,
with the advantage of avoiding overflow but with the disadvantage of a substantial
speed penalty. In Julia these are `BigInt`s, which we can create by calling `big` on an
integer:
```julia
x = typemax(Int64) + big(1) # Too big to be an `Int64`
```
Note in this case addition automatically promotes an `Int64` to a `BigInt`.
We can create very large numbers using `BigInt`:

```julia
x^100
```
Note the number of bits is not fixed, the larger the number, the more bits required 
to represent it, so while overflow is impossible, it is possible to run out of memory if a number is
astronomically large: go ahead and try `x^x` (at your own risk).


#### Division

 In addition to `+`, `-`, and `*` we have integer division `÷`, which rounds down:
```julia
5 ÷ 2 # equivalent to div(5,2)
```
Standard division `/` (or `\ ` for division on the right) creates a floating-point number,
which will be discussed shortly:
```julia
5 / 2 # alternatively 2 \ 5
```

 We can also create rational numbers using `//`:
```julia
(1//2) + (3//4)
```
Rational arithmetic often leads to overflow so it
is often best to combine `big` with rationals:
```julia
big(102324)//132413023 + 23434545//4243061 + 23434545//42430534435
```

### 3. Floating-point numbers

Floating-point numbers are a subset of real numbers that are representable using
a fixed number of bits.

>**Definition (floating-point numbers)**
>Given integers $σ$ (the "exponential shift") $Q$ (the number of exponent bits) and 
>$S$ (the precision), define the set of
>_Floating-point numbers_ by dividing into _normal_, _sub-normal_, and _special number_ subsets:
>$$
>F_{σ,Q,S} := F^{\rm normal}_{σ,Q,S} \cup F^{\rm sub}_{σ,Q,S} \cup F^{\rm special}.
>$$
>The _normal numbers_
>$F^{\rm normal}_{σ,Q,S} \subset {\mathbb R}$ are defined by
>$$
>F^{\rm normal}_{σ,Q,S} = \{\pm 2^{q-σ} \times (1.b_1b_2b_3\ldots b_S)_2 : 1 \leq q < 2^Q-1 \}.
>$$
>The _sub-normal numbers_ $F^{\rm sub}_{σ,Q,S} \subset {\mathbb R}$ are defined as
>$$
>F^{\rm sub}_{σ,Q,S} = \{\pm 2^{1-σ} \times (0.b_1b_2b_3\ldots b_S)_2\}.
>$$
>The _special numbers_ $F^{\rm special} \not\subset {\mathbb R}$ are defined later.

Note this set of real numbers has no nice algebraic structure: it is not closed under addition, subtraction, etc.
We will therefore need to define approximate versions of algebraic operations later.

Floating-point numbers are stored in $1 + Q + S$ total number of bits, in the format
$$
sq_{Q-1}\ldots q_0 b_1 \ldots b_S
$$
The first bit ($s$) is the <span style="color:#008080">sign bit</span>: 0 means positive and 1 means
negative. The bits $q_{Q-1}\ldots q_0$ are the <span style="color:green">exponent bits</span>:
they are the binary digits of the unsigned integer $q$: 
$$
q = (q_{Q-1}\ldots q_0)_2.
$$
Finally, the bits $b_1\ldots b_S$ are the <span style="color:#008080">significand bits</span>.
If $1 \leq q < 2^Q-1$ then the bits represent the normal number
$$
x = \pm 2^{q-σ} \times (1.b_1b_2b_3\ldots b_S)_2.
$$
If $q = 0$ (i.e. all bits are 0) then the bits represent the sub-normal number
$$
x = \pm 2^{1-σ} \times (0.b_1b_2b_3\ldots b_S)_2.
$$
If $q = 2^Q-1$  (i.e. all bits are 1) then the bits represent a special number, discussed
later.


#### IEEE floating-point numbers

>**Definition (IEEE floating-point numbers)** 
>IEEE has 3 standard floating-point formats: 16-bit (half precision), 32-bit (single precision) and
>64-bit (double precision) defined by:
>$$
>\begin{align*}
>F_{16} &:= F_{15,5,10} \\
>F_{32} &:= F_{127,8,23} \\
>F_{64} &:= F_{1023,11,52}
>\end{align*}
>$$

In Julia these correspond to 3 different floating-point types:

1.  `Float64` is a type representing double precision ($F_{64}$).
We can create a `Float64` by including a 
decimal point when writing the number: 
`1.0` is a `Float64`. `Float64` is the default format for 
scientific computing (on the _Floating-Point Unit_, FPU).  
2. `Float32` is a type representing single precision ($F_{32}$).  We can create a `Float32` by including a 
`f0` when writing the number: 
`1f0` is a `Float32`. `Float32` is generally the default format for graphics (on the _Graphics Processing Unit_, GPU), 
as the difference between 32 bits and 64 bits is indistinguishable to the eye in visualisation,
and more data can be fit into a GPU's limitted memory.
3.  `Float16` is a type representing half-precision ($F_{16}$).
It is important in machine learning where one wants to maximise the amount of data
and high accuracy is not necessarily helpful. 


**<span style="color:#008080">Example</span> (rational in `Float32`)** How is the number $1/3$ stored in `Float32`?
Recall that
$$
1/3 = (0.010101\ldots)_2 = 2^{-2} (1.0101\ldots)_2 = 2^{125-127} (1.0101\ldots)_2
$$
and since $125 = (1111101)_2$  the <span style="color:green">exponent bits</span> are `01111101`.
. 
For the significand we round the last bit to the nearest element of $F_{32}$, (this is explained in detail in
the section on rounding), so we have
$$
1.010101010101010101010101\ldots \approx 1.01010101010101010101011 \in F_{32} 
$$
and the <span style="color:#008080">significand bits</span> are `01010101010101010101011`.
Thus the `Float32` bits for $1/3$ are:
```julia
printbits(1f0/3)
```


For sub-normal numbers, the simplest example is zero, which has $q=0$ and all significand bits zero:
```julia
printbits(0.0)
```
Unlike integers, we also have a negative zero:
```julia
printbits(-0.0)
```
This is treated as identical to `0.0` (except for degenerate operations as explained in special numbers).



#### Special normal numbers

When dealing with normal numbers there are some important constants that we will use
to bound errors.

>**Definition (machine epsilon/smallest positive normal number/largest normal number)** _Machine epsilon_ is denoted
>$$
>ϵ_{{\rm m},S} := 2^{-S}.
>$$
>When $S$ is implied by context we use the notation $ϵ_{\rm m}$.
>The _smallest positive normal number_ is $q = 1$ and $b_k$ all zero:
>$$
>\min |F_{σ,Q,S}^{\rm normal}| = 2^{1-σ}
>$$
>where $|A| := \{|x| : x \in A \}$.
>The _largest (positive) normal number_ is 
>$$
>\max F_{σ,Q,S}^{\rm normal} = 2^{2^Q-2-σ} (1.11\ldots1)_2 = 2^{2^Q-2-σ} (2-ϵ_{\rm m})
>$$


We confirm the simple bit representations:
```julia
σ,Q,S = 127,23,8 # Float32
εₘ = 2.0^(-S)
printlnbits(Float32(2.0^(1-σ))) # smallest positive Float32
printlnbits(Float32(2.0^(2^Q-2-σ) * (2-εₘ))) # largest Float32
```
For a given floating-point type, we can find these constants using the following functions:
```julia
eps(Float32),floatmin(Float32),floatmax(Float32)
```

**<span style="color:#008080">Example</span> (creating a sub-normal number)** If we divide the smallest normal number by two, we get a subnormal number: 
```julia
mn = floatmin(Float32) # smallest normal Float32
printlnbits(mn)
printbits(mn/2)
```
Can you explain the bits?




#### Special numbers

The special numbers extend the real line by adding $\pm \infty$ but also a notion of "not-a-number".

>**Definition (not a number)**
>Let ${\rm NaN}$ represent "not a number" and define
>$$
>F^{\rm special} := \{\infty, -\infty, {\rm NaN}\}
>$$

Whenever the bits of $q$ of a floating-point number are all 1 then they represent an element of $F^{\rm special}$.
If all $b_k=0$, then the number represents either $\pm\infty$, called `Inf` and `-Inf` for 64-bit floating-point numbers (or `Inf16`, `Inf32`
for 16-bit and 32-bit, respectively):
```julia
printlnbits(Inf16)
printbits(-Inf16)
```
All other special floating-point numbers represent ${\rm NaN}$. One particular representation of ${\rm NaN}$ 
is denoted by `NaN` for 64-bit floating-point numbers (or `NaN16`, `NaN32` for 16-bit and 32-bit, respectively):
```julia
printbits(NaN16)
```
These are needed for undefined algebraic operations such as:
```julia
0/0
```


**<span style="color:#008080">Example</span> (many `NaN`s)** What happens if we change some other $b_k$ to be nonzero?
We can create bits as a string and see:
```julia
i = parse(UInt16, "0111110000010001"; base=2)
reinterpret(Float16, i)
```
Thus, there are more than one `NaN`s on a computer.  


### 4. Arithmetic


Arithmetic operations on floating-point numbers are  _exact up to rounding_.
There are three basic rounding strategies: round up/down/nearest.
Mathematically we introduce a function to capture the notion of rounding:

>**Definition (rounding)** ${\rm fl}^{\rm up}_{σ,Q,S} : \mathbb R \rightarrow F_{σ,Q,S}$ denotes 
>the function that rounds a real number up to the nearest floating-point number that is greater or equal.
>${\rm fl}^{\rm down}_{σ,Q,S} : \mathbb R \rightarrow F_{σ,Q,S}$ denotes 
>the function that rounds a real number down to the nearest floating-point number that is greater or equal.
>${\rm fl}^{\rm nearest}_{σ,Q,S} : \mathbb R \rightarrow F_{σ,Q,S}$ denotes 
>the function that rounds a real number to the nearest floating-point number. In case of a tie,
>it returns the floating-point number whose least significant bit is equal to zero.
>We use the notation ${\rm fl}$ when $σ,Q,S$ and the rounding mode are implied by context,
>with ${\rm fl}^{\rm nearest}$ being the default rounding mode.



In Julia, the rounding mode is specified by tags `RoundUp`, `RoundDown`, and
`RoundNearest`. (There are also more exotic rounding strategies `RoundToZero`, `RoundNearestTiesAway` and
`RoundNearestTiesUp` that we won't use.)



**<span style="color: red">WARNING</span>** **(rounding performance, advanced)** These rounding modes are part
of the FPU instruction set so will be (roughly) equally fast as the default, `RoundNearest`.
Unfortunately, changing the rounding mode is expensive, and is not thread-safe.




Let's try rounding a `Float64` to a `Float32`.

```julia
printlnbits(1/3)  # 64 bits
printbits(Float32(1/3))  # round to nearest 32-bit
```
The default rounding mode can be changed:
```julia
printbits(Float32(1/3,RoundDown) )
```
Or alternatively we can change the rounding mode for a chunk of code
using `setrounding`. The following computes upper and lower bounds for `/`:
```julia
x = 1f0
setrounding(Float32, RoundDown) do
    x/3
end,
setrounding(Float32, RoundUp) do
    x/3
end
```

**<span style="color: red">WARNING</span>** **(compiled constants, advanced)**: Why did we first create a variable `x` instead of typing `1f0/3`?
This is due to a very subtle issue where the compiler is _too clever for it's own good_: 
it recognises `1f0/3` can be computed at compile time, but failed to recognise the rounding mode
was changed. 

In IEEE arithmetic, the arithmetic operations `+`, `-`, `*`, `/` are defined by the property
that they are exact up to rounding.  Mathematically we denote these operations as follows:
$$
\begin{align*}
x\oplus y &:= {\rm fl}(x+y) \\
x\ominus y &:= {\rm fl}(x - y) \\
x\otimes y &:= {\rm fl}(x * y) \\
x\oslash y &:= {\rm fl}(x / y)
\end{align*}
$$
Note also that  `^` and `sqrt` are similarly exact up to rounding.


**<span style="color:#008080">Example</span> (decimal is not exact)** `1.1+0.1` gives a different result than `1.2`:
```julia
x = 1.1
y = 0.1
x + y - 1.2 # Not Zero?!?
```
This is because ${\rm fl}(1.1) \neq 1+1/10$, but rather:
$$
{\rm fl}(1.1) = 1 + 2^{-4}+2^{-5} + 2^{-8}+2^{-9}+\cdots + 2^{-48}+2^{-49} + 2^{-51}
$$
**<span style="color: red">WARNING</span>** **(non-associative)** **(non-associative)** These operations are not associative! E.g. $(x \oplus y) \oplus z$ is not necessarily equal to $x \oplus (y \oplus z)$. 
Commutativity is preserved, at least.
Here is a surprising example of non-associativity:
```julia
(1.1 + 1.2) + 1.3, 1.1 + (1.2 + 1.3)
```
Can you explain this in terms of bits?

#### Bounding errors in floating point arithmetic

Before we dicuss bounds on errors, we need to talk about the two notions of errors:

>**Definition (absolute/relative error)** If $\tilde x = x + δ_{rm a} = x (1 + δ_{\rm r})$ then 
>$|δ_{\rm a}|$ is called the _absolute error_ and $|δ_{\rm r}|$ is called the _relative error_ in approximating $x$ by $\tilde x$.

We can bound the error of basic arithmetic operations in terms of machine epsilon, provided
a real number is close to a normal number:

>**Definition (normalised range)** The _normalised range_ ${\cal N}_{σ,Q,S} \subset {\mathbb R}$
>is the subset of real numbers that lies
>between the smallest and largest normal floating-point number:
>$$
>{\cal N}_{σ,Q,S} := \{x : \min |F_{σ,Q,S}| \leq |x| \leq \max F_{σ,Q,S} \}
>$$
>When $σ,Q,S$ are implied by context we use the notation ${\cal N}$.

We can use machine epsilon to determine bounds on rounding:

>**Proposition (rounding arithmetic)**
>If $x \in {\cal N}$ then 
>$$
>{\rm fl}^{\rm mode}(x) = x (1 + \delta_x^{\rm mode})
>$$
>where the _relative error_ is
>$$
>\begin{align*}
>|\delta_x^{\rm nearest}| &\leq {ϵ_{\rm m} \over 2} \\
>|\delta_x^{\rm up/down}| &< {ϵ_{\rm m}}.
>\end{align*}
>$$


This immediately implies relative error bounds on all IEEE arithmetic operations, e.g., 
if $x+y \in {\cal N}$ then
we have
$$
x \oplus y = (x+y) (1 + \delta_1)
$$
where (assuming the default nearest rounding)
$
|\delta_1| \leq {ϵ_{\rm m} \over 2}.
$

**<span style="color:#008080">Example</span> (bounding a simple computation)** We show how to bound the error in computing
$$
(1.1 + 1.2) + 1.3
$$
using floating-point arithmetic. First note that `1.1` on a computer is in
fact ${\rm fl}(1.1)$. Thus this computation becomes
$$
({\rm fl}(1.1) \oplus {\rm fl}(1.2)) \oplus {\rm fl}(1.3)
$$
First we find
$$
({\rm fl}(1.1) \oplus {\rm fl}(1.2)) = (1.1(1 + δ_1) + 1.2 (1+δ_2))(1 + δ_3)
 = 2.3 + 1.1 δ_1 + 1.2 δ_2 + 2.3 δ_3 + 1.1 δ_1 δ_3 + 1.2 δ_2 δ_3
 = 2.3 + δ_4
$$
where (note $δ_1 δ_3$ and $δ_2 δ_3$ are tiny so we just round up our bound to the nearest decimal)
$$
|δ_4| \leq 2.3 ϵ_{\rm m}
$$
Thus the computation becomes
$$
((2.3 + δ_4) + 1.3 (1 + δ_5)) (1 + δ_6) = 3.6 + δ_4 + 1.3 δ_5 + 3.6 δ_6 + δ_4 δ_6  + 1.3 δ_5 δ_6 = 3.6 + δ_7
$$
where the _absolute error_ is
$$
|δ_7| \leq 4.8 ϵ_{\rm m}
$$
Indeed, this bound is bigger than the observed error:
```julia
abs(3.6 - (1.1+1.2+1.3)), 4.8eps()
```


#### Arithmetic and special numbers

Arithmetic works differently on `Inf` and `NaN` and for undefined operations. 
In particular we have:
```julia
1/0.0        #  Inf
1/(-0.0)     # -Inf
0.0/0.0      #  NaN
  
Inf*0        #  NaN
Inf+5        #  Inf
(-1)*Inf     # -Inf
1/Inf        #  0.0
1/(-Inf)     # -0.0
Inf - Inf    #  NaN
Inf ==  Inf  #  true
Inf == -Inf  #  false

NaN*0        #  NaN
NaN+5        #  NaN
1/NaN        #  NaN
NaN == NaN   #  false
NaN != NaN   #  true
```


#### Special functions (advanced)

Other special functions like `cos`, `sin`, `exp`, etc. are _not_ part of the IEEE standard.
Instead, they are implemented by composing the basic arithmetic operations, which accumulate
errors. Fortunately many are  designed to have _relative accuracy_, that is, `s = sin(x)` 
(that is, the Julia implementation of $\sin x$) satisfies
$$
{\tt s} = (\sin x) ( 1 + \delta)
$$
where $|\delta| < cϵ_{\rm m}$ for a reasonably small $c > 0$,
_provided_ that $x \in {\rm F}^{\rm normal}$.
Note these special functions are written in (advanced) Julia code, for example, [sin](https://github.com/JuliaLang/julia/blob/d08b05df6f01cf4ec6e4c28ad94cedda76cc62e8/base/special/trig.jl#L76).
**<span style="color: red">WARNING</span>** **(sin(fl(x)) is not always close to sin(x))** This is possibly a misleading statement
when one thinks of $x$ as a real number. Consider $x = \pi$ so that $\sin x = 0$.
However, as ${\rm fl}(\pi) \neq \pi$. Thus we only have relative accuracy compared
to the floating point approximation:

```julia
π₆₄ = Float64(π)
πᵦ = big(π₆₄) # Convert 64-bit approximation of π to higher precision. Note its the same number.
abs(sin(π₆₄)), abs(sin(π₆₄) - sin(πᵦ)) # only has relative accuracy compared to sin(πᵦ), not sin(π)
```
Another issue is when $x$ is very large:
```julia
ε = eps() # machine epsilon, 2^(-52)
x = 2*10.0^100
abs(sin(x) - sin(big(x)))  ≤  abs(sin(big(x))) * ε
```
But if we instead compute `10^100` using `BigFloat` we get a completely different
answer that even has the wrong sign!
```julia
x̃ = 2*big(10.0)^100
sin(x), sin(x̃)
```
This is because we commit an error on the order of roughly
$$
2 * 10^{100} * ϵ_{\rm m} \approx 4.44 * 10^{84}
$$
when we round $2*10^{100}$ to the nearest float. 


**<span style="color:#008080">Example</span> (polynomial near root)** 
For general functions we do not generally have relative accuracy. 
For example, consider a simple
polynomial $1 + 4x + x^2$ which has a root at $\sqrt 3 - 2$. But
```julia
f = x -> 1 + 4x + x^2
x = sqrt(3) - 2
abserr = abs(f(big(x)) - f(x))
relerr = abserr/abs(f(x))
abserr, relerr # very large relative error
```
We can see this in the error bound (note that $4x$ is exact for floating point numbers
and adding $1$ is exact for this particular $x$):
$$
(x \otimes x \oplus 4x) + 1 = (x^2 (1 + \delta_1) + 4x)(1+\delta_2) + 1 = x^2 + 4x + 1 + \delta_1 x^2 + 4x \delta_2 + x^2 \delta_1 \delta_2
$$
Using a simple bound $|x| < 1$ we get a (pessimistic) bound on the absolute error of
$3 ϵ_{\rm m}$. Here `f(x)` itself is less than $2 ϵ_{\rm m}$ so this does not imply
relative accuracy. (Of course, a bad upper bound is not the same as a proof of inaccuracy,
but here we observe the inaccuracy in practice.)

### 5. High-precision floating-point numbers (advanced)

It is possible to set the precision of a floating-point number
using the `BigFloat` type, which results from the usage of `big`
when the result is not an integer.
For example, here is an approximation of 1/3 accurate
to 77 decimal digits:

```julia
big(1)/3
```
Note we can set the rounding mode as in `Float64`, e.g., 
this gives (rigorous) bounds on
`1/3`:
```julia
setrounding(BigFloat, RoundDown) do
  big(1)/3
end, setrounding(BigFloat, RoundUp) do
  big(1)/3
end
```
We can also increase the precision, e.g., this finds bounds on `1/3` accurate to 
more than 1000 decimal places:
```julia
setprecision(4_000) do # 4000 bit precision
  setrounding(BigFloat, RoundDown) do
    big(1)/3
  end, setrounding(BigFloat, RoundUp) do
    big(1)/3
  end
end
```
In the problem sheet we shall see how this can be used to rigorously bound ${\rm e}$,
accurate to 1000 digits. 


------------------------------------------------------------------


## Differentiation
>**YouTube Lectures:**
>[Finite Differences](https://www.youtube.com/watch?v=cRYS5rnYzTY&feature=youtu.be)
>[Dual Numbers](https://www.youtube.com/watch?v=7mOobbvhXK0&feature=youtu.be)

We now get to our first computational problem: given a function, how can we approximate its derivative at a
point? Before we begin, we must be clear what a "function" is. Consider three possible scenarios:

1. _Black-box function_: Consider a floating-point valued function $f^{\rm FP} : D \rightarrow F$ where 
$D \subset F \equiv F_{\sigma,Q,S}$
(e.g., we are given a double precision function that takes in a `Float64` and returns another `Float64`)
which we only know _pointwise_. This is the situation if we have a function that relies on a compiled C library,
which composes floating point arithmetic operations.
Since $F$ is a discrete set such an $f^{\rm FP}$ cannot be differentiable in a rigorous way,
therefore we need to assume that $f^{\rm FP}$ approximates a differentiable function $f$ with controlled
error in order to state anything precise.
2. _Generic function_: Consider a function that is a formula (or, equivalentally, a _piece of code_) 
that we can evaluate it on arbitrary types, including
custom types that we create. An example is a polynomial:
$
p(x) = p_0 + p_1 x + \cdots + p_n x^n
$
which can be evaluated for $x$ in the reals, complexes, or any other ring.
 More generally, if we have a function defined in Julia that does not call any
C libraries it can be evaluated on different types. 
For analysis we typically consider both a differentiable function $f : D \rightarrow {\mathbb R}$ for
$D ⊂ {\mathbb R}$, 
which would be what one would have if we could evaluate a function exactly using real arithmetic, and 
$f^{\rm FP} : D \cap F \rightarrow F$, which is what we actually compute when evaluating the function using 
floating point arithmetic.
3. _Graph function_: The function is built by composing different basic "kernels" with known differentiability properties.
We won't consider this situation in this module, though it is the model used by Python machine learning toolbox's
like [PyTorch](https://pytorch.org) and [TensorFlow](http://tensorflow.org).

We discuss the following techniques:

1. Finite-differences: Use the definition of a derivative that one learns in calculus to approximate its value.
Unfortunately, the round-off errors of floating point arithmetic typically limit its accuracy.
2. Dual numbers (forward-mode automatic differentiation): Define a special type that when applied to a function
computes its derivative. Mathematically, this uses _dual numbers_, which are analoguous to complex numbers.

Note there are other techniques for differentiation that we don't discuss:

1. Symbolic differentiation: A tree is built representing a formula which is differentiated using
the product and chain rule.
2. Adjoints and back-propagation (reverse-mode automatic differentiation): This is similar to
symbolic differentiation but automated, to build up 
a tape of operations that tracks interdependencies. 
It's outside the scope of this module but is computationally preferred for computing gradients
of large dimensional functions which is critical in machine learning.
4. Interpolation and differentiation: We can also differentiate functions _globally_, that is, in an interval instead of
only a single point, which will be discussed later in the module.

```julia
using ColorBitstring
```


### 1. Finite-differences

The definition 
$$
f'(x) = \lim_{h \rightarrow 0} {f(x+h) - f(x) \over h}
$$
tells us that
$$
f'(x) \approx {f(x+h) - f(x) \over h}
$$
provided that $h$ is sufficiently small. 

It's important to note that approximation uses only the _black-box_
notion of a function but to obtain bounds we need more.

If we know a bound on $f''(x)$ then Taylor's theorem tells us a precise bound:

>**Proposition**
>The error in approximating the derivative using finite differences is
>$$
>\left|f'(x) - {f(x+h) - f(x) \over h}\right| \leq {M \over 2} h
>$$
>where $M = \sup_{x \leq t \leq x+h} |f''(t)|$.

==**Proof**==
Follows immediately from Taylor's theorem:
$$
f(x+h) = f(x) + f'(x) h + {f''(t) \over 2} h^2
$$
for some $x ≤ t ≤ x+h$.

◼️




There are also alternative versions of finite differences. Leftside finite-differences:
$$
f'(x) ≈ {f(x) - f(x-h) \over h}
$$
and central differences:
$$
f'(x) ≈ {f(x + h) - f(x - h) \over 2h}
$$
Composing these approximations is useful for higher-order derivatives as we 
discuss in the problem sheet.

Note this is assuming _real arithmetic_, the answer is drastically
different with _floating point arithmetic_.

#### Does finite-differences work with floating point arithmetic?
Let's try differentiating two simple polynomials $f(x) = 1 + x + x^2$ and $g(x) = 1 + x/3 + x^2$
by applying the finite-difference approximation to their floating point implementations
$f^{\rm FP}$ and $g^{\rm FP}$:
```julia
f = x -> 1 + x + x^2     # we treat f and g as black-boxs
g = x -> 1 + x/3 + x^2
h = 0.000001
(f(h)-f(0))/h, (g(h)-g(0))/h
```
Both seem to roughly approximate the true derivatives ($1$ and $1/3$).
We can do a plot to see how fast the error goes down as we let $h$ become small. 
```julia
using Plots
h = 2.0 .^ (0:-1:-60)  # [1,1/2,1/4,…]
nanabs = x -> iszero(x) ? NaN : abs(x) # avoid 0's in log scale plot
plot(nanabs.((f.(h) .- f(0)) ./ h .- 1); yscale=:log10, title="convergence of derivatives, h = 2^(-n)", label="f", legend=:bottomleft)
plot!(abs.((g.(h) .- g(0)) ./ h .- 1/3); yscale=:log10, label = "g")
```
In the case of $f$ it is a success: we approximate the true derivative _exactly_ provided we take $h = 2^{-n}$
for $26 < n \leq 52$.
But for $g$ it is a huge failure: the approximation starts to converge, but then diverges exponentially fast, before levelling off!

It is clear that $f$ is extremely special. Most functions will behave like $g$, and had we not taken
$h$ to be a power of two we also see divergence for differentiating $f$: 
```julia
h = 10.0 .^ (0:-1:-16)  # [1,1/10,1/100,…]
plot(abs.((f.(h) .- f(0)) ./ h .- 1); yscale=:log10, title="convergence of derivatives, h = 10^(-n)", label="f", legend=:bottomleft)
plot!(abs.((g.(h) .- g(0)) ./ h .- 1/3); yscale=:log10, label = "g")
```
For these two simple
examples, we can understand why we see very different behaviour.


**<span style="color:#008080">Example</span> (convergence(?) of finite difference)** Consider differentiating $f(x) = 1 + x + x^2$ at 0 with $h = 2^{-n}$.
We consider 3 different cases with different behaviour, where $S$ is the number of significand bits: 

1. $0 ≤ n ≤ S/2$
2. $S/2 < n ≤ S$
3. $S ≤ n$

Note that $f^{\rm FP}(0) = f(0) = 1$. Thus we wish to understand the error in approximating $f'(0) = 1$ by
$$
(f^{\rm FP}(h) ⊖ 1) ⊘ h\qquad\hbox{where}\qquad f^{\rm FP}(x) = 1 ⊕ x ⊕ x ⊗ x.
$$

_Case 1_ ($0 ≤ n ≤ S/2$): note that $f^{\rm FP}(h) = f(h) = 1 + 2^{-n} + 2^{-2n}$
as each computation is precisely a floating point number (hence no rounding). We can see this in half-precision,
with $n = 3$ we have a 1 in the 3rd and 6th decimal place:
```julia
S = 10 # 10 significant bits
n = 3  # 3 ≤ S/2 = 5
h = Float16(2)^(-n)
printbits(f(h))
```
Subtracting 1 and dividing by $h$ will also be exact, hence we get
$$
(f^{\rm FP}(h) ⊖ 1) ⊘ h = 1 + 2^{-n}
$$
which shows exponential convergence.

_Case 2_ ($S/2 < n ≤ S$): Now we have (using round-to-nearest)
$$
f^{\rm FP}(h) = (1 + 2^{-n}) ⊕ 2^{-2n} = 1 + 2^{-n}
$$
Then
$$
(f^{\rm FP}(h) ⊖ 1) ⊘ h = 1 = f'(0)
$$
We have actually performed better than true real arithmetic and converged without a limit!

_Case 3_ ($n > S$): If we take $n$ too large, then $1 ⊕ h = 1$ and we have $f^{\rm FP}(h) = 1$, that is and 
$$
(f^{\rm FP}(h) ⊖ 1) ⊘ h = 0 \neq f'(0)
$$

**<span style="color:#008080">Example</span> (divergence of finite difference)** Consider differentiating $g(x) = 1 + x/3 + x^2$ at 0 with $h = 2^{-n}$
and assume $n$ is even for simplicity and consider half-precision with $S = 10$.
Note that $g^{\rm FP}(0) = g(0) = 1$.
Recall
$$
h ⊘ 3 = 2^{-n-2} * (1.0101010101)_2
$$
Note we lose two bits each time in the computation of $1 ⊕ (h ⊘ 3)$: 
```julia
n = 0; h = Float16(2)^(-n); printlnbits(1 + h/3)
n = 2; h = Float16(2)^(-n); printlnbits(1 + h/3)
n = 4; h = Float16(2)^(-n); printlnbits(1 + h/3)
n = 8; h = Float16(2)^(-n); printlnbits(1 + h/3)
```
It follows if $S/2 < n < S$ that
$$
1 ⊕ (h ⊘ 3) = 1 + h/3 - 2^{-10}/3
$$
Therefore
$$
(g^{\rm FP}(h) ⊖ 1) ⊘ h = 1/3 - 2^{n-10}/3
$$
Thus the error grows exponentially with $n$. 


If $n ≥ S$ then $1 ⊕ (h ⊘ 3) = 1$ and we have
$$
(g^{\rm FP}(h) ⊖ 1) ⊘ h = 0
$$


#### Bounding the error


We can bound the error using the bounds on floating point arithmetic. 

>**Theorem (finite-difference error bound)** Let $f$ be twice-differentiable in a neighbourhood of $x$ and assume that 
>$f^{\rm FP}(x) = f(x) + δ_x^f$ has uniform absolute accuracy in that neighbourhood, that is:
>$$
>|δ_x^f| \leq c ϵ_{\rm m}
>$$
>for a fixed constant $c$. Assume for simplicity $h = 2^{-n}$ where $n \leq S$ and $|x| \leq 1$. 
>Then the finite-difference approximation satisfies
>$$
>(f^{\rm FP}(x + h) ⊖ f^{\rm FP}(x)) ⊘ h = f'(x) + δ_{x,h}^{\rm FD}
>$$
>where 
>$$
>|δ_{x,h}^{\rm FD}| \leq {|f'(x)| \over 2} ϵ_{\rm m} + M h +  {4c ϵ_{\rm m} \over h}
>$$
>for $M = \sup_{x \leq t \leq x+h} |f''(t)|$.

==**Proof**==

We have (noting by our assumptions $x ⊕ h = x + h$ and that dividing by $h$ will only change the exponent so
is exact)
$$
\begin{align*}
(f^{\rm FP}(x + h) ⊖ f^{\rm FP}(x)) ⊘ h &= {f(x + h) +  δ^f_{x+h} - f(x) - δ^f_x \over h} (1 + δ_1) \\
&= {f(x+h) - f(x) \over h} (1 + δ_1) + {δ^f_{x+h}- δ^f_x \over h} (1 + δ_1)
\end{align*}
$$
where $|δ_1| \leq {ϵ_{\rm m} / 2}$. Applying Taylor's theorem we get 
$$
(f^{\rm FP}(x + h) ⊖ f^{\rm FP}(x)) ⊘ h = f'(x) + \underbrace{f'(x) δ_1 + {f''(t) \over 2} h (1 + \delta_1) + {δ^f_{x+h}- δ^f_x \over h} (1 + δ_1)}_{δ_{x,h}^{\rm FD}}
$$
The bound then follows, using the very pessimistic bound $|1 + δ_1| \leq 2$.



The three-terms of this bound tell us a story: the first term is a fixed (small) error, the second term tends to zero
as $h \rightarrow 0$, while the last term grows like $ϵ_{\rm m}/h$ as $h \rightarrow 0$.  Thus we observe convergence
while the second term dominates, until the last term takes over.
Of course, a bad upper bound is not the same as a proof that something grows, but it is a good indication of 
what happens _in general_ and suffices to motivate the following heuristic to balance the two sources of errors:


**Heuristic (finite-difference with floating-point step)** Choose $h$ proportional to $\sqrt{ϵ_{\rm m}}$
in finite-differences.

In the case of double precision $\sqrt{ϵ_{\rm m}} ≈ 1.5\times 10^{-8}$, which is close to when the observed error begins to increase
in our examples.



**<span style="color:#005757">Remark:</span>** While finite differences is of debatable utility for computing derivatives, it is extremely effective
in building methods for solving differential equations, as we shall see later. It is also very useful as a "sanity check"
if one wants something to compare with for other numerical methods for differentiation.

### 2. Dual numbers (Forward-mode automatic differentiation)

Automatic differentiation consists of applying functions to special types that determine the derivatives.
Here we do so via _dual numbers_.

>**Definition (Dual numbers)** Dual numbers ${\mathbb D}$ are a commutative ring over the reals 
>generated by $1$ and $ϵ$ such that $ϵ^2 = 0$.
>Dual numbers are typically written as $a + b ϵ$ where $a$ and $b$ are real.

This is very much analoguous to complex numbers, which are a field generated by $1$ and ${\rm i}$ such that
${\rm i}^2 = -1$. Compare multiplication of each number type:
$$
\begin{align*}
(a + b {\rm i}) (c + d {\rm i}) &= ac + (bc + ad) {\rm i} + bd {\rm i}^2 = ac -bd + (bc + ad) {\rm i} \\
(a + b ϵ) (c + d ϵ) &= ac + (bc + ad) ϵ + bd ϵ^2 = ac  + (bc + ad) ϵ 
\end{align*}
$$
And just as we view ${\mathbb R} \subset {\mathbb C}$ by equating $a \in {\mathbb R}$ with $a + 0{\rm i} \in {\mathbb C}$,
we can view ${\mathbb R} \subset {\mathbb D}$ by equating $a \in {\mathbb R}$ with $a + 0{\rm ϵ} \in {\mathbb D}$.




#### Connection with differentiation

Applying a polynomial to a dual number $a + b ϵ$ tells us the derivative at $a$:

>**Theorem (polynomials on dual numbers)** Suppose $p$ is a polynomial. Then
>$$
>p(a + b ϵ) = p(a) + b p'(a) ϵ
>$$

==**Proof**==

It suffices to consider $p(x) = x^n$ for $n \geq 1$ as other polynomials follow from linearity. We proceed by induction:
The case $n = 1$ is trivial. For $n > 1$ we have 
$$
(a + b ϵ)^n = (a + b ϵ) (a + b ϵ)^{n-1} = (a + b ϵ) (a^{n-1} + (n-1) b a^{n-2} ϵ) = a^n + b n a^{n-1} ϵ.
$$



We can extend real-valued differentiable functions to dual numbers in a similar manner.
First, consider a standard function with a Taylor series (e.g. ${\rm cos}$, ${\rm sin}$, ${\rm exp}$, etc.)
$$
f(x) = \sum_{k=0}^∞ f_k x^k
$$
so that $a$ is inside the radius of convergence. This leads naturally to a definition on dual numbers:
$$
\begin{align*}
f(a + b ϵ) &= \sum_{k=0}^∞ f_k (a + b ϵ)^k = \sum_{k=0}^∞ f_k (a^k + k a^{k-1} b ϵ) = \sum_{k=0}^∞ f_k a^k +  \sum_{k=0}^∞ f_k k a^{k-1} b ϵ  \\
  &= f(a) + b f'(a) ϵ
\end{align*}
$$
More generally, given a differentiable function we can extend it to dual numbers:

>**Definition (dual extension)** Suppose a real-valued function $f$
>is differentiable at $a$. If
>$$
>f(a + b ϵ) = f(a) + b f'(a) ϵ
>$$
>then we say that it is a _dual extension at_ $a$.

Thus, for basic functions we have natural extensions:
$$
\begin{align*}
\exp(a + b ϵ) &:= \exp(a) + b \exp(a) ϵ \\
\sin(a + b ϵ) &:= \sin(a) + b \cos(a) ϵ \\
\cos(a + b ϵ) &:= \cos(a) - b \sin(a) ϵ \\
\log(a + b ϵ) &:= \log(a) + {b \over a} ϵ \\
\sqrt{a+b ϵ} &:= \sqrt{a} + {b \over 2 \sqrt{a}} ϵ \\
|a + b ϵ| &:= |a| + b\, {\rm sign} a\, ϵ
\end{align*}
$$
provided the function is differentiable at $a$. Note the last example does not have
a convergent Taylor series (at 0) but we can still extend it where it is differentiable.

Going further, we can add, multiply, and compose such functions:

>**Lemma (product and chain rule)**
>If $f$ is a dual extension at $g(a)$ and $g$
>is a dual extension at $a$, then $q(x) := f(g(x))$ is a dual extension at $a$.
>If $f$ and $g$ are dual extensions at $a$ then 
>$r(x) := f(x) g(x)$ is also dual extensions at $a$. In other words:
>$$
>\begin{align*}
>q(a+b ϵ) &= q(a) + b q'(a) ϵ \\
>r(a+b ϵ) &= r(a) + b r'(a) ϵ
>\end{align*}
>$$

==**Proof**==
For $q$ it follows immediately:
$$
q(a + b ϵ) = f(g(a + b ϵ)) = f(g(a) + b g'(a) ϵ) = f(g(a)) + b g'(a) f'(g(a))ϵ = q(a) + b q'(a) ϵ.
$$
For $r$ we have
$$
r(a + b ϵ) = f(a+b ϵ )g(a+b ϵ )= (f(a) + b f'(a) ϵ)(g(a) + b g'(a) ϵ)  \\
= f(a)g(a) + b (f'(a)g(a) + f(a)g'(a)) ϵ = r(a) +b r'(a) ϵ.
$$



A simple corollary is that any function defined in terms of addition, multiplication, composition, etc.
of functions that are dual with differentiation will be differentiable via dual numbers.

**<span style="color:#008080">Example</span> (differentiating non-polynomial)**

Consider $f(x) =  \exp(x^2 + {\rm e}^{x})$ by evaluating on the duals:
$$
f(1 + ϵ) = \exp(1 + 2ϵ + {\rm e} + {\rm e} ϵ) =  \exp(1 + {\rm e}) + \exp(1 + {\rm e}) (2 + {\rm e}) ϵ
$$
and therefore we deduce that
$$
f'(1) = \exp(1 + {\rm e}) (2 + {\rm e}).
$$


#### Implementation as a special type


We now consider a simple implementation of dual numbers that works on general polynomials:
```julia
# Dual(a,b) represents a + b*ϵ
struct Dual{T}
    a::T
    b::T
end

# Dual(a) represents a + 0*ϵ
Dual(a::Real) = Dual(a, zero(a)) # for real numbers we use a + 0ϵ

# Allow for a + b*ϵ syntax
const ϵ = Dual(0, 1)

import Base: +, *, -, /, ^, zero, exp

# support polynomials like 1 + x, x - 1, 2x or x*2 by reducing to Dual
+(x::Real, y::Dual) = Dual(x) + y
+(x::Dual, y::Real) = x + Dual(y)
-(x::Real, y::Dual) = Dual(x) - y
-(x::Dual, y::Real) = x - Dual(y)
*(x::Real, y::Dual) = Dual(x) * y
*(x::Dual, y::Real) = x * Dual(y)

# support x/2 (but not yet division of duals)
/(x::Dual, k::Real) = Dual(x.a/k, x.b/k)

# a simple recursive function to support x^2, x^3, etc.
function ^(x::Dual, k::Integer)
    if k < 0
        error("Not implemented")
    elseif k == 1
        x
    else
        x^(k-1) * x
    end
end

# Algebraic operationds for duals
-(x::Dual) = Dual(-x.a, -x.b)
+(x::Dual, y::Dual) = Dual(x.a + y.a, x.b + y.b)
-(x::Dual, y::Dual) = Dual(x.a - y.a, x.b - y.b)
*(x::Dual, y::Dual) = Dual(x.a*y.a, x.a*y.b + x.b*y.a)

exp(x::Dual) = Dual(exp(x.a), exp(x.a) * x.b)
```

We can also try it on the two polynomials as above:
```julia
f = x -> 1 + x + x^2
g = x -> 1 + x/3 + x^2
f(ϵ).b, g(ϵ).b
```
The first example exactly computes the derivative, and the
second example is exact up to the last bit rounding!
It also works for higher order polynomials:
```julia
f = x -> 1 + 1.3x + 2.1x^2 + 3.1x^3
f(0.5 + ϵ).b - 5.725
```
It is indeed "accurate to (roughly) 16-digits", the best we can hope for 
using floating point.

We can use this in "algorithms" as well as simple polynomials.
Consider the polynomial $1 + … + x^n$:
```julia
function s(n, x)
    ret = 1 + x # first two terms
    for k = 2:n
        ret += x^k
    end
    ret
end
s(10, 0.1 + ϵ).b
```
This matches exactly the "true" (up to rounding) derivative:
```julia
sum((1:10) .* 0.1 .^(0:9))
```

Finally, we can try the more complicated example:
```julia
f = x -> exp(x^2 + exp(x))
f(1 + ϵ)
```

What makes dual numbers so effective is that, unlike finite differences, they are not
prone to disasterous growth due to round-off errors. 

-----------------------------------------------------------------

## Structured Matrices
>**YouTube Lectures:**
>[Structured Matrices](https://www.youtube.com/watch?v=-tMU_3os7dY&feature=youtu.be)
>[Permutation Matrices](https://www.youtube.com/watch?v=-Jtbp5tCN54)
>[Orthogonal Matrices](https://www.youtube.com/watch?v=nqMjWXwe9kI&feature=youtu.be)

We have seen how algebraic operations (`+`, `-`, `*`, `/`) are
well-defined for floating point numbers. Now we see how this allows us
to do (approximate) linear algebra operations on structured matrices. That is,
we consider the following structures:


1. _Dense_: This can be considered unstructured, where we need to store all entries in a
vector or matrix. Matrix multiplication reduces directly to standard algebraic operations. 
Solving linear systems with dense matrices will be discussed later.
2. _Triangular_: If a matrix is upper or lower triangular, we can immediately invert using
back-substitution. In practice we store a dense matrix and ignore the upper/lower entries.
3. _Banded_: If a matrix is zero apart from entries a fixed distance from  the diagonal it is
called banded and this allows for more efficient algorithms. We discuss diagonal, 
tridiagonal and bidiagonal matrices.
3. _Permutation_: A permutation matrix permutes the rows of a vector. 
4. _Orthogonal_: An orthogonal matrix $Q$ satisfies $Q^⊤ Q = I$, in other words, they are
very easy to invert. We discuss the special cases of simple rotations and reflections.


```julia
using LinearAlgebra, Plots, BenchmarkTools
```


### 1. Dense vectors and matrices

A `Vector` of a primitive type (like `Int` or `Float64`) is stored
consecutively in memory. E.g. if we have a `Vector{Int8}` of length
`n` then it is stored as `8n` bits (`n` bytes) in a row.
A  `Matrix` is stored consecutively in memory, going down column-by-
column. That is,
```julia
A = [1 2;
     3 4;
     5 6]
```
Is actually stored equivalently to a length `6` vector:
```julia
vec(A)
```
This is known as _column-major_ format.

**<span style="color:#005757">Remark:</span>** Note that transposing `A` is done lazyily and so `A'`
stores the entries by row. That is, `A'` is stored in 
_row-major_ format.


Matrix-vector multiplication works as expected:
```julia
x = [7, 8]
A*x
```

Note there are two ways this can be implemented: either the traditional definition,
going row-by-row:
$$
\begin{bmatrix} \sum_{j=1}^n a_{1,j} x_j \\ \vdots \\ \sum_{j=1}^n a_{m,j} x_j \end{bmatrix}
$$
or going column-by-column:
$$
x_1 𝐚_1  + \cdots + x_n 𝐚_n
$$
It is easy to implement either version of matrix-multiplication in terms of the algebraic operations 
we have learned, in this case just using integer arithmetic:
```julia
## go row-by-row
function mul_rows(A, x)
    m,n = size(A)
    # promote_type type finds a type that is compatible with both types, eltype gives the type of the elements of a vector / matrix
    c = zeros(promote_type(eltype(x),eltype(A)), m)
    for k = 1:m, j = 1:n
        c[k] += A[k, j] * x[j]
    end
    c
end

## go column-by-column
function mul(A, x)
    m,n = size(A)
    # promote_type type finds a type that is compatible with both types, eltype gives the type of the elements of a vector / matrix
    c = zeros(promote_type(eltype(x),eltype(A)), m)
    for j = 1:n, k = 1:m
        c[k] += A[k, j] * x[j]
    end
    c
end

mul_rows(A, x), mul(A, x)
```

Either implementation will be $O(mn)$ operations. However, the implementation 
`mul` accesses the entries of `A` going down the column,
which happens to be _significantly faster_ than `mul_rows`, due to accessing
memory of `A` in order. We can see this by measuring the time it takes using `@btime`:
```julia
n = 1000
A = randn(n,n) # create n x n matrix with random normal entries
x = randn(n) # create length n vector with random normal entries

@btime mul_rows(A,x)
@btime mul(A,x)
@btime A*x; # built-in, high performance implementation. USE THIS in practice
```
Here `ms` means milliseconds (`0.001 = 10^(-3)` seconds) and `μs` means microseconds (`0.000001 = 10^(-6)` seconds).
So we observe that `mul` is roughly 3x faster than `mul_rows`, while the optimised `*` is roughly 5x faster than `mul`.


**<span style="color:#005757">Remark:</span> (advanced)** For floating point types, `A*x` is implemented in BLAS which is generally multi-threaded
and is not identical to `mul(A,x)`, that is, some inputs will differ in how the computations
are rounded.


Note that the rules of arithmetic apply here: matrix multiplication with floats
will incur round-off error (the precise details of which are subject to the implementation):

```julia
A = [1.4 0.4;
     2.0 1/2]
A * [1, -1] # First entry has round-off error, but 2nd entry is exact
```
And integer arithmetic will be prone to overflow:
```julia
A = fill(Int8(2^6), 2, 2) # make a matrix whose entries are all equal to 2^6
A * Int8[1,1] # we have overflowed and get a negative number -2^7
```


Solving a linear system is done using `\ `:
```julia
A = [1 2 3;
     1 2 4;
     3 7 8]
b = [10; 11; 12]
A \ b
```
Despite the answer being integer-valued, 
here we see that it resorted to using floating point arithmetic,
incurring rounding error. 
But it is "accurate to (roughly) 16-digits".
As we shall see, the way solving a linear system works is we first write `A` as a
product of simpler matrices, e.g., a product of triangular matrices.

**<span style="color:#005757">Remark:</span> (advanced)** For floating point types, `A \ x` is implemented in LAPACK, which
like BLAS is generally multi-threaded and in fact different machines may round differently.


### 2. Triangular matrices

Triangular matrices are represented by dense square matrices where the entries below the
diagonal
are ignored:
```julia
A = [1 2 3;
     4 5 6;
     7 8 9]
U = UpperTriangular(A)
```
We can see that `U` is storing all the entries of `A`:
```julia
U.data
```
Similarly we can create a lower triangular matrix by ignoring the entries above the diagonal:
```julia
L = LowerTriangular(A)
```

If we know a matrix is triangular we can do matrix-vector multiplication in roughly half
the number of operations. 
Moreover, we can easily invert matrices. 
Consider a simple 3×3 example, which can be solved with `\ `:
```julia
b = [5,6,7]
x = U \ b
```
Behind the seens, `\ ` is doing back-substitution: considering the last row, we have all
zeros apart from the last column so we know that `x[3]` must be equal to:
```julia
b[3] / U[3,3]
```
Once we know `x[3]`, the second row states `U[2,2]*x[2] + U[2,3]*x[3] == b[2]`, rearranging
we get that `x[2]` must be:
```julia
(b[2] - U[2,3]*x[3])/U[2,2]
```
Finally, the first row states `U[1,1]*x[1] + U[1,2]*x[2] + U[1,3]*x[3] == b[1]` i.e.
`x[1]` is equal to
```julia
(b[1] - U[1,2]*x[2] - U[1,3]*x[3])/U[1,1]
```

More generally, we can solve the upper-triangular system
$$
\begin{bmatrix}
u_{11} & \cdots & u_{1n} \\ & \ddots & \vdots \\ && u_{nn}
\end{bmatrix} \begin{bmatrix} x_1 \\ \vdots \\ x_n \end{bmatrix} = 
\begin{bmatrix} b_1 \\ \vdots \\ b_n \end{bmatrix}
$$
by computing $x_n, x_{n-1}, \ldots, x_1$ by the back-substitution formula:
$$
x_k = {b_k - \sum_{j=k+1}^n u_{kj} x_j \over u_{kk}}
$$



The problem sheet will explore implementing this method, as well
as forward substitution for inverting lower triangular matrices. The cost of multiplying and solving linear systems with a
triangular matrix is $O(n^2)$.


### 3. Banded matrices

A _banded matrix_ is zero off a prescribed number of diagonals. 
We call the number of (potentially) non-zero diagonals the _bandwidths_:

> **Definition (bandwidths)** A matrix $A$ has _lower-bandwidth_ $l$ if 
> $A[k,j] = 0$ for all $k-j > l$ and _upper-bandwidth_ $u$ if
> $A[k,j] = 0$ for all $j-k > u$. We say that it has _strictly lower-bandwidth_ $l$
> if it has lower-bandwidth $l$ and there exists a $j$ such that $A[j+l,j] \neq 0$.
> We say that it has _strictly upper-bandwidth_ $u$
> if it has upper-bandwidth $u$ and there exists a $k$ such that $A[k,k+u] \neq 0$.


#### Diagonal

> **Definition (Diagonal)** _Diagonal matrices_ are square matrices with bandwidths $l = u = 0$.


Diagonal matrices in Julia are stored as a vector containing the diagonal entries:
```julia
x = [1,2,3]
D = Diagonal(x)
```
It is clear that we can perform diagonal-vector multiplications and solve linear systems involving diagonal matrices efficiently
(in $O(n)$ operations).

#### Bidiagonal

> **Definition (Bidiagonal)** If a square matrix has bandwidths $(l,u) = (1,0)$ it is _lower-bidiagonal_ and
> if it has bandwidths $(l,u) = (0,1)$ it is _upper-bidiagonal_. 

We can create Bidiagonal matrices in Julia by specifying the diagonal and off-diagonal:

```julia
Bidiagonal([1,2,3], [4,5], :L)
```
```julia
Bidiagonal([1,2,3], [4,5], :U)
```

Multiplication and solving linear systems with Bidiagonal systems is also $O(n)$ operations, using the standard
multiplications/back-substitution algorithms but being careful in the loops to only access the non-zero entries. 


#### Tridiagonal

> **Definition (Tridiagonal)** If a square matrix has bandwidths $l = u = 1$ it is _tridiagonal_.

Julia has a type `Tridiagonal` for representing a tridiagonal matrix from its sub-diagonal, diagonal, and super-diagonal:
```julia
Tridiagonal([1,2], [3,4,5], [6,7])
```
Tridiagonal matrices will come up in second-order differential equations and orthogonal polynomials.
We will later see how linear systems involving tridiagonal matrices can be solved in $O(n)$ operations.

### 4. Permutation Matrices

Permutation matrices are matrices that represent the action of permuting the entries of a vector,
that is, matrix representations of the symmetric group $S_n$, acting on $ℝ^n$.
Recall every $σ \in S_n$ is a bijection between $\{1,2,\ldots,n\}$ and itself.
We can write a permutation $σ$ in _Cauchy notation_:
$$
\begin{pmatrix}
 1 & 2 & 3 & \cdots & n \cr
 σ_1 & σ_2 & σ_3 & \cdots & σ_n
 \end{pmatrix}
$$
where $\{σ_1,\ldots,σ_n\} = \{1,2,\ldots,n\}$ (that is, each integer appears precisely once).
We denote the _inverse permutation_ by $σ^{-1}$, which can be constructed by swapping the rows of
the Cauchy notation and reordering.

We can encode a permutation in vector $\mathbf σ = [σ_1,\ldots,σ_n]^⊤$. 
This induces an action on a vector (using indexing notation)
$$
𝐯[\mathbf σ] = \begin{bmatrix}v_{σ_1}\\ \vdots \\ v_{σ_n} \end{bmatrix}
$$


**<span style="color:#008080">Example</span> (permutation of a vector)** 
Consider the permutation $σ$ given by
$$
\begin{pmatrix}
 1 & 2 & 3 & 4 & 5 \cr
 1 & 4 & 2 & 5 & 3
 \end{pmatrix}
$$
We can apply it to a vector:
```julia
σ = [1, 4, 2, 5, 3]
v = [6, 7, 8, 9, 10]
v[σ] # we permutate entries of v
```
Its inverse permutation $σ^{-1}$ has Cauchy notation coming from swapping the rows of
the Cauchy notation of $σ$ and sorting:
$$
\begin{pmatrix}
 1 & 4 & 2 & 5 & 3 \cr
 1 & 2 & 3 & 4 & 5
 \end{pmatrix} \rightarrow \begin{pmatrix}
 1 & 2 & 4 & 3 & 5 \cr
 1 & 3 & 2 & 5 & 4
 \end{pmatrix} 
$$
Julia has the function `invperm` for computing the vector that encodes
the inverse permutation:
And indeed:
```julia
σ⁻¹ = invperm(σ) # note that ⁻¹ are just unicode characters in the variable name
```
And indeed permuting the entries by `σ` and then by `σ⁻¹` returns us
to our original vector:
```julia
v[σ][σ⁻¹] # permuting by σ and then σⁱ gets us back
```



Note that the operator
$$
P_σ(𝐯) = 𝐯[\mathbf σ]
$$
is linear in $𝐯$, therefore, we can identify it with a matrix whose action is:
$$
P_σ \begin{bmatrix} v_1\\ \vdots \\ v_n \end{bmatrix} = \begin{bmatrix}v_{σ_1} \\ \vdots \\ v_{σ_n}  \end{bmatrix}.
$$
The entries of this matrix are
$$
P_σ[k,j] = 𝐞_k^⊤ P_σ 𝐞_j = 𝐞_k^⊤ 𝐞_{σ^{-1}_j} = δ_{k,σ^{-1}_j} = δ_{σ_k,j}
$$
where $δ_{k,j}$ is the _Kronecker delta_:
$$
δ_{k,j} := \begin{cases} 1 & k = j \\
                        0 & \hbox{otherwise}
                        \end{cases}.
$$


This construction motivates the following definition:

>**Definition (permutation matrix)** $P \in ℝ^{n × n}$ is a permutation matrix if it is equal to
>the identity matrix with its rows permuted.

**<span style="color:#008080">Example</span> (5×5 permutation matrix)**
We can construct the permutation representation for $σ$ as above as follows:
```julia
P = I(5)[σ,:]
```
And indeed, we see its action is as expected:
```julia
P * v
```

**<span style="color:#005757">Remark:</span> (advanced)** Note that `P` is a special type `SparseMatrixCSC`. This is used
to represent a matrix by storing only the non-zero entries as well as their location.
This is an important data type in high-performance scientific computing, but we will not
be using general sparse matrices in this module.

>**Proposition (permutation matrix inverse)** 
>Let $P_σ$ be a permutation matrix corresponding to the permutation $σ$. Then
>$$
>P_σ^⊤ = P_{σ^{-1}} = P_σ^{-1}
>$$
>That is, $P_σ$ is _orthogonal_:
>$$
>P_σ^⊤ P_σ = P_σ P_σ^⊤ = I.
>$$

==**Proof**==

We prove orthogonality via:
$$
𝐞_k^⊤ P_σ^⊤ P_σ 𝐞_j = (P_σ 𝐞_k)^⊤ P_σ 𝐞_j = 𝐞_{σ^{-1}_k}^⊤ 𝐞_{σ^{-1}_j} = δ_{k,j}
$$
This shows $P_σ^⊤ P_σ = I$ and hence $P_σ^{-1} = P_σ^⊤$. 




Permutation matrices are examples of sparse matrices that can be very easily inverted. 



### 4. Orthogonal matrices


>**Definition (orthogonal matrix)** A square matrix is _orthogonal_ if its inverse is its transpose:
>$$
>Q^⊤ Q = QQ^⊤ = I.
>$$

We have already seen an example of an orthogonal matrices (permutation matrices). 
Here we discuss two important special cases: simple rotations and reflections.

#### Simple rotations


>**Definition (simple rotation)**
>A 2×2 _rotation matrix_ through angle $θ$ is
>$$
>Q_θ := \begin{bmatrix} \cos \theta & -\sin \theta \cr \sin \theta & \cos \theta \end{bmatrix}
>$$

In what follows we use the following for writing the angle of a vector:

>**Definition (two-arg arctan)** The two-argument arctan function gives the angle `θ` through the point
>$[a,b]^\top$, i.e., 
>$$
>\sqrt{a^2 + b^2} \begin{bmatrix} \cos θ \\ \sin θ \end{bmatrix} =  \begin{bmatrix} a \\ b \end{bmatrix}
>$$
>It can be defined in terms of the standard arctan as follows:
>$$
>{\rm atan}(b,a) := \begin{cases} {\rm atan}{b \over a} & a > 0 \\
>                            {\rm atan}{b \over a} + π & a < 0\hbox{ and }b >0 \\
>                            {\rm atan}{b \over a} + π & a < 0\hbox{ and }b < 0 \\
>                            π/2 & a = 0\hbox{ and }b >0 \\
>                            -π/2 & a = 0\hbox{ and }b < 0 
>                            \end{cases}
>$$

This is available in Julia:
```julia
atan(-1,-2) # angle through [-2,-1]
```


We can rotate an arbitrary vector to the unit axis. Interestingly it only requires
basic algebraic functions (no trigonometric functions):



>**Proposition (rotation of a vector)** 
>The matrix
>$$
>Q = {1 \over \sqrt{a^2 + b^2}}\begin{bmatrix}
> a & b \cr -b & a
>\end{bmatrix}
>$$
>is a rotation matrix satisfying
>$$
>Q \begin{bmatrix} a \\ b \end{bmatrix} = \sqrt{a^2 + b^2} \begin{bmatrix} 1 \\ 0 \end{bmatrix}
>$$

==**Proof**== 

The last equation is trivial so the only question is that it is a rotation matrix.
Define $θ = -{\rm atan}(b, a)$. By definition of the two-arg arctan we have
$$
\begin{bmatrix}
\cos θ & -\sin θ \\
\sin θ &\cos θ
\end{bmatrix} = \begin{bmatrix}
\cos(-θ) & \sin(-θ) \\
-\sin(-θ) & \cos(-θ)
\end{bmatrix} = {1\over \sqrt{a^2 + b^2}} \begin{bmatrix} a  & b \\ -b &a \end{bmatrix}.
$$






#### Reflections

In addition to rotations, another type of orthognal matrix are reflections:

>**Definition (reflection matrix)** 
>Given a vector $𝐯$ satisfying $\|𝐯\|=1$, the reflection matrix is the orthogonal matrix
>$$
>Q_𝐯 \triangleq I - 2 𝐯 𝐯^⊤
>$$

These are reflections in the direction of $𝐯$. We can show this as follows:

>**Proposition** $Q_𝐯$ satisfies:
>1. Symmetry: $Q_𝐯 = Q_𝐯^⊤$
>2. Orthogonality: $Q_𝐯^⊤ Q_𝐯 = I$
>2. $𝐯$ is an eigenvector of $Q_𝐯$ with eigenvalue $-1$
>4. $Q_𝐯$ is a rank-1 perturbation of $I$
>3. $\det Q_𝐯 = -1$


==**Proof**==

Property 1 follows immediately. Property 2 follows from
$$
Q_𝐯^⊤ Q_𝐯 = Q_𝐯^2 = I - 4 𝐯 𝐯^⊤ + 4 𝐯 𝐯^⊤ 𝐯 𝐯^⊤ = I
$$
Property 3 follows since
$$
Q_𝐯 𝐯 = -𝐯
$$
Property 4 follows since $𝐯 𝐯^⊤$ is a rank-1 matrix as all rows are linear combinations of each other.
To see property 5, note there is a dimension $n-1$ space $W$ orthogonal to $𝐯$, that is, for all
$𝐰 \in W$ we have $𝐰^⊤ 𝐯 = 0$, which implies that
$$
Q_𝐯 𝐰 = 𝐰
$$
In other words, $1$ is an eigenvalue with multiplicity $n-1$ and $-1$ is an eigenvalue with multiplicity 1,
and thus the product of the eigenvalues is $-1$.





**<span style="color:#008080">Example</span> (reflection through 2-vector)** Consider reflection through $𝐱 = [1,2]^\top$. 
We first need to normalise $𝐱$:
$$
𝐯 = {𝐱 \over \|𝐱\|} = \begin{bmatrix} {1 \over \sqrt{5}} \\ {2 \over \sqrt{5}} \end{bmatrix}
$$
Note this indeed has unit norm:
$$
\|𝐯\|^2 = {1 \over 5} + {4 \over 5} = 1.
$$
Thus the reflection matrix is:
$$
Q_𝐯 = I - 2 𝐯 𝐯^⊤ = \begin{bmatrix}1 \\ & 1 \end{bmatrix} - {2 \over 5} \begin{bmatrix} 1 & 2 \\ 2 & 4 \end{bmatrix}
 =  {1 \over 5} \begin{bmatrix} 3 & -4 \\ -4 & -3 \end{bmatrix}
$$
Indeed it is symmetric, and orthogonal. It sends $𝐱$ to $-𝐱$:
$$
Q_𝐯 𝐱 = {1 \over 5} \begin{bmatrix}3 - 8 \\ -4 - 6 \end{bmatrix} = -𝐱
$$
Any vector orthogonal to $𝐱$, like $𝐲 = [-2,1]^\top$, is left fixed:
$$
Q_𝐯 𝐲 = {1 \over 5} \begin{bmatrix}-6 -4 \\ 8 - 3 \end{bmatrix} = 𝐲
$$


Note that _building_ the matrix $Q_𝐯$ will be expensive ($O(n^2)$ operations), but we can apply
$Q_𝐯$ to a vector in $O(n)$ operations using the expression:
$$
Q_𝐯 𝐱 = 𝐱 - 2 𝐯 (𝐯^⊤ 𝐱).
$$


Just as rotations can be used to rotate vectors to be aligned with coordinate axis, so can reflections,
but in this case it works for vectors in $ℝ^n$, not just $ℝ^2$:

>**Definition (Householder reflection)** For a given vector
>$𝐱$, define the Householder reflection
>$$
>Q_𝐱^{±,\rm H} := Q_𝐰
>$$
>for $𝐲 = ∓ \|𝐱\| 𝐞_1 + 𝐱$ and $𝐰 = {𝐲 \over \|𝐲\|}$.
>The default choice in sign is:
>$$
>Q_𝐱^{\rm H} := Q_𝐱^{-\hbox{sign}(x_1),\rm H}.
>$$

>**Lemma (Householder reflection)**
>$$
>Q_𝐱^{±,\rm H} 𝐱 = ±\|𝐱\| 𝐞_1
>$$

==**Proof**==
Note that
$$
\begin{align*}
\| 𝐲 \|^2 &= 2\|𝐱\|^2 ∓ 2 \|𝐱\| x_1, \\
𝐲^⊤ 𝐱 &= \|𝐱\|^2 ∓  \|𝐱\| x_1
\end{align*}
$$
where $x_1 = 𝐞_1^\top 𝐱$. Therefore:
$$
Q_𝐱^{±,\rm H} 𝐱  =  (I - 2 𝐰 𝐰^⊤) 𝐱 = 𝐱 - 2 {𝐲  \|𝐱\|  \over \|𝐲\|^2} (\|𝐱\|∓x_1) = 𝐱 - 𝐲 =  ±\|𝐱\| 𝐞_1.
$$



Why do we choose the the opposite sign of $x_1$ for the default reflection? For stability.
We demonstrate the reason for this by numerical example. Consider $𝐱 = [1,h]$, i.e., a small perturbation
from $𝐞_1$. If we reflect to $\hbox{norm}(𝐱)𝐞_1$ we see a numerical problem:
```julia
h = 10.0^(-10)
x = [1,h]
y = -norm(x)*[1,0] + x
w = y/norm(y)
Q = I-2w*w'
Q*x
```
It didn't work! Even worse is if `h = 0`:
```julia
h = 0
x = [1,h]
y = -norm(x)*[1,0] + x
w = y/norm(y)
Q = I-2w*w'
Q*x
```
This is because `y` has large relative error due to cancellation
from floating point errors in computing the first entry `x[1] - norm(x)`. 
(Or has norm zero if `h=0`.)
We avoid this cancellation by using the default choice:
```julia
h = 10.0^(-10)
x = [1,h]
y = sign(x[1])*norm(x)*[1,0] + x
w = y/norm(y)
Q = I-2w*w'
Q*x
```

----------------------------------------------------------------

## Decompositions and least squares
>**YouTube Lectures:**
>[Least squares and QR](https://www.youtube.com/watch?v=nR5Tku-IPmA)
>[Gram-Schmidt and Reduced QR](https://www.youtube.com/watch?v=g5uIUAGvWKA&feature=youtu.be)
>[Householder and QR](https://www.youtube.com/watch?v=NKegcR0ifHk&feature=youtu.be)
>[PLU Decomposition](https://www.youtube.com/watch?v=V6OVjhyIvpY&feature=youtu.be)
>[Cholesky Decomposition](https://www.youtube.com/watch?v=9XTgOj-q4Ug)


We now look at several decompositions (or factorisations) 
of a matrix into products of structured matrices, and their use in solving least squares problems and linear systems.
For a square or rectangular matrix $A ∈ ℝ^{m × n}$ with more rows than columns ($m ≥ n$), we consider:
1. The _QR decomposition_
$$
A = Q R = \underbrace{\begin{bmatrix} 𝐪_1 | \cdots | 𝐪_m \end{bmatrix}}_{m × m} \underbrace{\begin{bmatrix} × & \cdots & × \\ & ⋱ & ⋮ \\ && × \\ &&0 \\ &&⋮ \\ && 0 \end{bmatrix}}_{m × n}
$$
where $Q$ is orthogonal ($Q^⊤Q = I$, $𝐪_j ∈ ℝ^m$) and $R$ is _right triangular_, which means it 
is only nonzero on or to the right of the diagonal.

2. The _reduced QR decomposition_
$$
A = Q̂ R̂ = \underbrace{\begin{bmatrix} 𝐪_1 | \cdots | 𝐪_n \end{bmatrix}}_{m × n} \underbrace{\begin{bmatrix} × & \cdots & × \\ & ⋱ & ⋮ \\ && ×  \end{bmatrix}}_{n × n}
$$
where $Q$ has orthogonal columns ($Q^⊤Q = I$, $𝐪_j ∈ ℝ^m$) and $R̂$ is upper triangular.

For a square matrix we consider the _PLU decomposition_:
$$
A = P^⊤ LU
$$
where $P$ is a permutation matrix, $L$ is lower triangular and $U$ is upper triangular.

Finally, for a square, _symmetric positive definite_ ($𝐱^⊤ A 𝐱 > 0$ for all $𝐱 ∈ ℝ^n$, $𝐱 \neq 0$) 
matrix we consider the _Cholesky decomposition_:
$$
A = L L^⊤
$$

The importance of these decomposition for square matrices is that their component pieces are easy to invert on a computer:
$$
\begin{align*}
A = P^⊤ LU &\Rightarrow\qquad A^{-1}𝐛 = U^{-1} L^{-1} P 𝐛 \\
A = QR &\Rightarrow\qquad A^{-1}𝐛 = R^{-1} Q^\top 𝐛 \\
A = L L^⊤ &\Rightarrow\qquad A^{-1}𝐛 = L^{-⊤} L^{-1} 𝐛
\end{align*}
$$
and we saw last lecture that triangular and orthogonal matrices are easy to invert when applied to a vector $𝐛$,
e.g., using forward/back-substitution.
For rectangular matrices we will see that they lead to efficient solutions to the _least squares problem_: find
$𝐱$ that minimizes the 2-norm
$$
\| A 𝐱 - 𝐛 \|.
$$

In this lecture we discuss the followng:

1. QR and least squares: We discuss the QR decomposition and its usage in solving least squares problems.
2. Reduced QR and Gram–Schmidt: We discuss computation of the Reduced QR decomposition using Gram–Schmidt.
3. Householder reflections and QR: We discuss comuting the  QR decomposition using Householder reflections.
2. PLU decomposition: we discuss how the LU decomposition can be computed using Gaussian elimination, and the computation of
the PLU decomposition via Gaussian elimination with pivoting.
3. Cholesky decomposition: we introduce symmetric positive definite matrices and show that their LU decomposition can be re-interpreted
as a Cholesky decomposition.
4. Timings: we see the relative trade-off in speed between the different decompositions.

```julia
using LinearAlgebra, Plots, BenchmarkTools
```



### 1. QR and least squares

Here we consider rectangular matrices with more rows than columns.
A QR decomposition decomposes a matrix into an orthogonal matrix $Q$ times a right triangular matrix $R$. 
Note the QR decomposition contains within it the reduced QR decomposition:
$$
A = QR = \begin{bmatrix} Q̂ | 𝐪_{n+1} | ⋯ | 𝐪_m \end{bmatrix} \begin{bmatrix} R̂ \\  𝟎_{m-n × n} \end{bmatrix} = Q̂ R̂.
$$


We can use it to solve a least squares problem using the norm-preserving property (see PS3) of orthogonal matrices:
$$
\| A 𝐱 - 𝐛 \| = \| Q R 𝐱 - 𝐛 \| = \| R 𝐱 - Q^⊤ 𝐛 \| = \left \| 
\begin{bmatrix} R̂ \\ 𝟎_{m-n × n} \end{bmatrix} 𝐱 - \begin{bmatrix} Q̂^⊤ \\ 𝐪_{n+1}^⊤ \\ ⋮ \\ 𝐪_m^⊤ \end{bmatrix}     𝐛 \right \|
$$
Now note that the rows $k > n$ are independent of $𝐱$ and are a fixed contribution. Thus to minimise this norm it suffices to
drop them and minimise:
$$
\| R̂ 𝐱 - Q̂^⊤ 𝐛 \|
$$
This norm is minimisable if it is attained. Provided the column rank of $A$ is full, $R̂$ will be invertible (Exercise: why is this?).
Thus we have the solution
$$
𝐱 = R̂^{-1} Q̂^⊤ 𝐛
$$

**<span style="color:#008080">Example</span> (quadratic fit)** Suppose we want to fit noisy data by a quadratic
$$
p(x) = p₀ + p₁ x + p₂ x^2
$$
That is, we want to choose $p₀,p₁,p₂$ at data samples $x_1, \ldots, x_m$ so that the following is true:
$$
p₀ + p₁ x_k + p₂ x_k^2 ≈ f_k
$$
where $f_k$ are given by data. We can reinterpret this as a least squares problem: minimise the norm
$$
\left\| \begin{bmatrix} 1 & x_1 & x_1^2 \\ ⋮ & ⋮ & ⋮ \\ 1 & x_m & x_m^2 \end{bmatrix}
\begin{bmatrix} p₀ \\ p₁ \\ p₂ \end{bmatrix} - \begin{bmatrix} f_1 \\ ⋮ \\ f_m \end{bmatrix} \right \|
$$
We can solve this using the QR decomposition:
```julia
m,n = 100,3

x = range(0,1; length=m) # 100 points
f = 2 .+ x .+ 2x.^2 .+ 0.1 .* randn.() # Noisy quadratic

A = x .^ (0:2)'  # 100 x 3 matrix, equivalent to [ones(m) x x.^2]
Q,R̂ = qr(A)
Q̂ = Q[:,1:n] # Q represents full orthogonal matrix so we take first 3 columns

p₀,p₁,p₂ = R̂ \ Q̂'f
```
We can visualise the fit:
```julia
p = x -> p₀ + p₁*x + p₂*x^2

scatter(x, f; label="samples", legend=:bottomright)
plot!(x, p.(x); label="quadratic")
```
Note that `\ ` with a rectangular system does least squares by default:
```julia
A \ f
```





#### 2. Reduced QR and Gram–Schmidt


How do we compute the QR decomposition? We begin with a method
you may have seen before in another guise. Write
$$
A = \begin{bmatrix} 𝐚_1 | \dots | 𝐚_n \end{bmatrix}
$$
where $𝐚_k \in  ℝ^m$ and assume they are linearly independent ($A$ has full column rank).
Note that the column span of the first $j$ columns of $A$
will be the same as the first $j$ columns of $Q̂$, as
$R̂$ must be non-singular:
$$
\hbox{span}(𝐚_1,\ldots,𝐚_j) = \hbox{span}(𝐪_1,\ldots,𝐪_j)
$$
In other words: the columns of $Q̂$ are an orthogonal basis
of the column span of $A$.
To see this note that since `R̂` is triangular we have
$$
\begin{bmatrix} 𝐚_1 | \dots | 𝐚_j \end{bmatrix} = \begin{bmatrix} 𝐪_1 | \dots | 𝐪_j \end{bmatrix}  R̂[1:j,1:j]
$$
for all $j$. That is, if $𝐯 ∈ \hbox{span}(𝐚_1,\ldots,𝐚_j)$ we have for $𝐜 ∈ ℝ^j$
$$
𝐯 = \begin{bmatrix} 𝐚_1 | \dots | 𝐚_j \end{bmatrix} 𝐜 = \begin{bmatrix} 𝐪_1 | \dots | 𝐪_j \end{bmatrix}  R̂[1:j,1:j] 𝐜 ∈ \hbox{span}(𝐪_1,\ldots,𝐪_j)
$$
 while if $𝐰 ∈ \hbox{span}(𝐪_1,\ldots,𝐪_j)$ we have for $𝐝 ∈ ℝ^j$
$$
𝐰 = \begin{bmatrix} 𝐪_1 | \dots | 𝐪_j \end{bmatrix} 𝐝  =  \begin{bmatrix} 𝐚_1 | \dots | 𝐚_j \end{bmatrix} R̂[1:j,1:j]^{-1} 𝐝 ∈  \hbox{span}(𝐚_1,\ldots,𝐚_j).
$$


It is possible to find an orthogonal basis using the _Gram–Schmidt algorithm_,
We construct it via induction:
assume that
$$
\hbox{span}(𝐚_1,\ldots,𝐚_{j-1}) = \hbox{span}(𝐪_1,\ldots,𝐪_{j-1})
$$
where $𝐪_1,\ldots,𝐪_{j-1}$ are orthogonal:
$$
𝐪_k^\top 𝐪_ℓ = δ_{kℓ} = \begin{cases} 1 & k = ℓ \\
                                            0 & \hbox{otherwise} \end{cases}.
$$
for $k,ℓ < j$.
Define
$$
𝐯_j := 𝐚_j - \sum_{k=1}^{j-1} \underbrace{𝐪_k^\top 𝐚_j}_{r_{kj}} 𝐪_k
$$
so that for $k < j$
$$
𝐪_k^\top 𝐯_j = 𝐪_k^\top 𝐚_j - \sum_{k=1}^{j-1} \underbrace{𝐪_k^\top 𝐚_j}_{r_{kj}} 𝐪_k^\top 𝐪_k = 0.
$$
Then we define
$$
𝐪_j := {𝐯_j \over \|𝐯_j\|}.
$$
which sastisfies $𝐪_k^\top 𝐪_j =δ_{kj}$ for $k \leq j$.

We now reinterpret this construction as a reduced QR decomposition.
Define $r_{jj} := {\|𝐯_j\|}$
Then rearrange the definition we have
$$
𝐚_j = \begin{bmatrix} 𝐪_1|\cdots|𝐪_j \end{bmatrix} \begin{bmatrix} r_{1j} \\ ⋮ \\ r_{jj} \end{bmatrix}
$$
Thus
$$
\begin{bmatrix} 𝐚_1|\cdots|𝐚_j \end{bmatrix} 
\begin{bmatrix} r_{11} & \cdots & r_{1j} \\ & ⋱ & ⋮ \\ && r_{jj} \end{bmatrix}
$$
That is, we are computing the reduced QR decomposition column-by-column. 
Running this algorithm to $j = n$ completes the decomposition.

##### Gram–Schmidt in action

We are going to compute the reduced QR of a random matrix
```julia
m,n = 5,4
A = randn(m,n)
Q,R̂ = qr(A)
Q̂ = Q[:,1:n]
```
The first column of `Q̂` is indeed a normalised first column of `A`:
```julia
R = zeros(n,n)
Q = zeros(m,n)
R[1,1] = norm(A[:,1])
Q[:,1] = A[:,1]/R[1,1]
```
We now determine the next entries as
```julia
R[1,2] = Q[:,1]'A[:,2]
v = A[:,2] - Q[:,1]*R[1,2]
R[2,2] = norm(v)
Q[:,2] = v/R[2,2]
```
And the third column is then:
```julia
R[1,3] = Q[:,1]'A[:,3]
R[2,3] = Q[:,2]'A[:,3]
v = A[:,3] - Q[:,1:2]*R[1:2,3]
R[3,3] = norm(v)
Q[:,3] = v/R[3,3]
```
(Note the signs may not necessarily match.)

We can clean this up as a simple algorithm:
```julia
function gramschmidt(A)
    m,n = size(A)
    m ≥ n || error("Not supported")
    R = zeros(n,n)
    Q = zeros(m,n)
    for j = 1:n
        for k = 1:j-1
            R[k,j] = Q[:,k]'*A[:,j]
        end
        v = A[:,j] - Q[:,1:j-1]*R[1:j-1,j]
        R[j,j] = norm(v)
        Q[:,j] = v/R[j,j]
    end
    Q,R
end

Q,R = gramschmidt(A)
norm(A - Q*R)
```


##### Complexity and stability

We see within the `for j = 1:n` loop that we have $O(mj)$ operations. Thus the 
total complexity is $O(m n^2)$ operations.


Unfortunately, the Gram–Schmidt algorithm is _unstable_: the rounding errors when implemented in floating point
accumulate in a way that we lose orthogonality:
```julia
A = randn(300,300)
Q,R = gramschmidt(A)
norm(Q'Q-I)
```

#### 3. Householder reflections and QR

As an alternative, we will consider using Householder reflections to introduce zeros below
the diagonal.
Thus, if Gram–Schmidt is a process of _triangular orthogonalisation_ (using triangular matrices
to orthogonalise), Householder reflections is a process of _orthogonal triangularisation_ 
(using orthogonal matrices to triangularise).

Consider multiplication by the Householder reflection corresponding to the first column,
that is, for
$$
Q_1 := Q_{𝐚_1}^{\rm H},
$$
consider
$$
Q_1 A = \begin{bmatrix} × & × & \cdots & × \\
& × & \cdots & × \\
                    & ⋮ & ⋱ & ⋮ \\
                    & × & \cdots & × \end{bmatrix} = 
\begin{bmatrix} r_{11} & r_{12} & \cdots & r_{1n} \\ 
& 𝐚_2^1 & \cdots & 𝐚_n^1   \end{bmatrix}
$$
where 
$$
r_{1j} :=  (Q_1 𝐚_j)[1] \qquad \hbox{and} \qquad 𝐚_j^1 := (Q_1 𝐚_j)[2:m],
$$
noting $r_{11} = -\hbox{sign}(a_{11})\|𝐚_1\|$ and all entries of $𝐚_1^1$ are zero (thus not included).
That is, we have made the first column triangular.

But now consider
$$
Q_2 := \begin{bmatrix} 1  \\ & Q_{𝐚_2^1}^{\rm H} \end{bmatrix} = Q_{\begin{bmatrix} 0 \\ 𝐚_2^1 \end{bmatrix}}^H
$$
so that
$$
Q_2 Q_1A = \begin{bmatrix} × & × & × & \cdots & × \\
& × & ×  & \cdots & × \\
                    && ⋮ & ⋱ & ⋮ \\
                    && × & \cdots & × \end{bmatrix}  =  \begin{bmatrix} r_{11} & r_{12} & r_{13} & \cdots & r_{1n} \\ 
    & r_{22} & r_{23} & \cdots & r_{2n} \\
&& 𝐚_3^2 & \cdots & 𝐚_n^2   \end{bmatrix}
$$
where 
$$
r_{2j} :=  (Q_2 𝐚_j^1)[1] \qquad \hbox{and} \qquad 𝐚_j^2 := (Q_2 𝐚_j^1)[2:m-1]
$$
Thus the first two columns are triangular. 

The inductive construction is thus clear. If we define $𝐚_j^0 := 𝐚_j$ we
have the construction
$$
\begin{align*}
Q_j &:= \begin{bmatrix} I_{j-1 × j-1}  \\ & Q_{𝐚_j^j}^{±,\rm H} \end{bmatrix} \\
𝐚_j^k &:= (Q_k 𝐚_j^{k-1})[2:m-k+1] \\
r_{kj} &:= (Q_k 𝐚_j^{k-1})[1]
\end{align*}
$$
Then
$$
Q_n \cdots Q_1 A = \underbrace{\begin{bmatrix} 
r_{11} & \cdots & r_{1n} \\ & ⋱ & ⋮\\
                                        && r_{nn} \\&& 0 \\ && ⋮ \\ && 0 \end{bmatrix}}_R
$$
i.e.
$$
A = \underbrace{Q_1 \cdots Q_n}_Q R.
$$

The implementation is cleaner. We do a naive implementation here:
```julia
function householderreflection(x)
    y = copy(x)
    # we cannot use sign(x[1]) in case x[1] == 0
    y[1] += (x[1] ≥ 0 ? 1 : -1)*norm(x) 
    w = y/norm(y)
    I - 2*w*w'
end
function householderqr(A)
    m,n = size(A)
    R = copy(A)
    Q = Matrix(1.0I, m, m)
    for j = 1:n
        Qⱼ = householderreflection(R[j:end,j])
        R[j:end,:] = Qⱼ*R[j:end,:]
        Q[:,j:end] = Q[:,j:end]*Qⱼ
    end
    Q,R
end

m,n = 7,5
A = randn(m, n)
Q,R = householderqr(A)
Q*R ≈ A
```
Note because we are forming a full matrix representation of each Householder
reflection this is a slow algorithm, taking $O(n^4)$ operations. The problem sheet
will consider a better implementation that takes $O(n^3)$ operations.


**<span style="color:#008080">Example</span>** We will now do an example by hand. Consider the $4 × 3$ matrix
$$
A = \begin{bmatrix} 
1 & 2 & -1 \\ 
0 & 15 & 18 \\
-2 & -4 & -4 \\
-2 & -4 & -10
\end{bmatrix}
$$
For the first column we have
$$
Q_1 = I - {1 \over 12} \begin{bmatrix} 4 \\ 0 \\ -2 \\ -2 \end{bmatrix} \begin{bmatrix} 4 & 0 & -2 & -2 \end{bmatrix} =
{1 \over 3} \begin{bmatrix}
-1 & 0 & 2 & 2 \\
0 & 3 & 0 & 0 \\
2 & 0 & 2 & -1 \\
2 & 0 & -1 &2
\end{bmatrix}
$$
so that
$$
Q_1 A = \begin{bmatrix} -3 & -6 & -9 \\
 & 15 & 18 \\
  & 0 & 0 \\
& 0 & -6
\end{bmatrix}
$$
In this example the next column is already upper-triangular,
but because of our choice of reflection we will end up swapping the sign, that is
$$
Q_2 = \begin{bmatrix} 1 \\ & -1 \\ && 1 \\ &&& 1 \end{bmatrix}
$$
so that
$$
Q_2 Q_1 A = \begin{bmatrix} -3 & -6 & -9 \\
 & -15 & -18 \\
  & 0 & 0 \\
& 0 & -6
\end{bmatrix}
$$
The final reflection is
$$
Q_3 = \begin{bmatrix} I_{2 × 2} \\ &  I - \begin{bmatrix} 1 \\ -1 \end{bmatrix} \begin{bmatrix} 1 & -1 \end{bmatrix} 
\end{bmatrix} = \begin{bmatrix} å1 \\ & 1 \\ & & 0 & 1 \\ & & 1 & 0 \end{bmatrix}
$$
giving us
$$
Q_3 Q_2 Q_1 A = \underbrace{\begin{bmatrix} -3 & -6 & -9 \\
 & -15 & -18 \\
  &  & -6 \\
&  & 0
\end{bmatrix}}_R
$$
That is,
$$
A = Q_1 Q_2 Q_3 R = \underbrace{{1 \over 3} \begin{bmatrix}
-1 & 0 & 2 & 2 \\
0 & 3 & 0 & 0 \\
2 & 0 & -1 & 2 \\
2 & 0 & 2 &-1
\end{bmatrix}}_Q \underbrace{\begin{bmatrix} -3 & -6 & -9 \\
 & -15 & -18 \\
  &  & -6 \\
&  & 0
\end{bmatrix}}_R = \underbrace{{1 \over 3} \begin{bmatrix}
-1 & 0 & 2  \\
0 & 3 & 0  \\
2 & 0 & -1  \\
2 & 0 & 2 
\end{bmatrix}}_Q̂  \underbrace{\begin{bmatrix} -3 & -6 & -9 \\
 & -15 & -18 \\
  &  & -6 
\end{bmatrix}}_R̂
$$



### 2. PLU Decomposition

Just as Gram–Schmidt can be reinterpreted as a reduced QR decomposition,
Gaussian elimination with pivoting can be interpreted as a PLU decomposition.


#### Special "one-column" lower triangular matrices


Consider the following set of $n × n$ lower triangular
matrices which equals identity apart from one-column:
$$
{\cal L}_j := \left\{I + \begin{bmatrix} 𝟎_j \\ 𝐥_j \end{bmatrix} 𝐞_j^⊤ : 𝐥_j ∈ ℝ^{n-j} \right\}
$$
where  $𝟎_j$ denotes the zero vector of length $j$. 
That is, if $L_j ∈ {\cal L}_j$ then it is equal to the identity matrix apart from in the $j$ th column:
$$
L_j = \begin{bmatrix}
        1 \\ & {⋱} \\ && 1 \\
                    && ℓ_{j+1,j} & 1 \\
                    && ⋮ && \dots \\
                    && ℓ_{n,j} & & & 1 \end{bmatrix} = 
$$

These satisify the following special properties:

>**Proposition (one-column lower triangular inverse)**
>If $L_j \in {\cal L}_j$ then
>$$
>L_j^{-1}  = I - \begin{bmatrix} 𝟎_j \\ 𝐥_j \end{bmatrix} 𝐞_j^⊤ = \begin{bmatrix}
>        1 \\ & ⋱ \\ && 1 \\
>                    &&-ℓ_{j+1,j} & 1 \\
>                    &&⋮ && \dots \\
>                    &&-ℓ_{n,j} & & & 1 \end{bmatrix} ∈ {\cal L}_j.
>$$


>**Proposition (one-column lower triangular multiplication)**
>If $L_j \in {\cal L}_j$ and $L_k \in {\cal L}_k$ for $k ≥ j$ then
>$$
>L_j L_k =  I + \begin{bmatrix} 𝟎_j \\ 𝐥_j \end{bmatrix} 𝐞_j^⊤ +  \begin{bmatrix} 𝟎_k \\ 𝐥_k \end{bmatrix} 𝐞_k^⊤
>$$


>**Lemma (one-column lower triangular with pivoting)**
>If $σ$ is a permutation that leaves the first $j$
>rows fixed (that is, $σ_ℓ = ℓ$ for $ℓ ≤ j$) and $L_j ∈ {\cal L}_j$ then
>$$
>P_σ L_j=  \tilde L_j P_σ
>$$
>where $\tilde L_j ∈ {\cal L}_j$.

==**Proof**==
Write
$$
P_σ = \begin{bmatrix} I_j \\ & P_τ \end{bmatrix}
$$
where $τ$ is the permutation with Cauchy notation
$$
\begin{pmatrix}
1 & \cdots & n-j \\
σ_{j+1}-j & ⋯ & σ_n-j
\end{pmatrix}
$$
Then we have
$$
P_σ L_j = P_σ + \begin{bmatrix} 𝟎_j \\ P_τ 𝐥_j \end{bmatrix} 𝐞_j^⊤ =
\underbrace{(I +  \begin{bmatrix} 𝟎_j \\ P_τ 𝐥_j \end{bmatrix} 𝐞_j^⊤)}_{\tilde L_j} P_σ
$$
noting that $𝐞_j^⊤ P_σ = 𝐞_j^⊤$ (as $σ_j = j$). 



#### LU Decomposition

Before discussing pivoting, consider standard Gaussian elimation where one row-reduces
to introduce zeros column-by-column. We will mimick the computation of the QR decomposition
to view this as a _triangular triangularisation_.


Consider the matrix
$$
L_1 = \begin{bmatrix} 1 \\ -{a_{21} \over a_{11}} & 1 \\ ⋮ &&⋱ \\
                -{a_{n1} \over a_{11}}  &&& 1
                \end{bmatrix} = I - \begin{bmatrix} 0 \\ {𝐚_1[2:n] \over 𝐚_1[1]} \end{bmatrix}  𝐞_1^\top.
$$
We then have
$$
L_1 A =  \begin{bmatrix} u_{11} & u_{12} & \cdots & u_{1n} \\ 
& 𝐚_2^1 & \cdots & 𝐚_n^1   \end{bmatrix}
$$
where $𝐚_j^1 := (L_1 𝐚_j)[2:n]$ and $u_{1j} = a_{1j}$. But now consider
$$
L_2 := I - \begin{bmatrix} 0 \\ {𝐚_2^1[2:n-1] \over 𝐚_2^1[1]} \end{bmatrix}  𝐞_1^\top.
$$
Then
$$
L_2 L_1 A = \begin{bmatrix} u_{11} & u_{12} & u_{13} & \cdots & u_{1n} \\ 
    & u_{22} & u_{23} & \cdots & u_{2n} \\
&& 𝐚_3^2 & \cdots & 𝐚_n^2   \end{bmatrix}
$$
where 
$$
u_{2j} :=  (𝐚_j^1)[1] \qquad \hbox{and} \qquad 𝐚_j^2 := (L_2 𝐚_j^1)[2:n-1]
$$
Thus the first two columns are triangular. 

The inductive construction is again clear. If we define $𝐚_j^0 := 𝐚_j$ we
have the construction
$$
\begin{align*}
L_j &:= I - \begin{bmatrix} 𝟎_j \\ {𝐚_{j+1}^j[2:n-j] \over 𝐚_{j+1}^j[1]} \end{bmatrix} 𝐞_j^⊤ \\
𝐚_j^k &:= (L_k 𝐚_j^{k-1})[2:n-k+1]
 \\
u_{kj} &:= (L_k 𝐚_j^{k-1})[1]
\end{align*}
$$
Then
$$
L_{n-1} \cdots L_1 A = \underbrace{\begin{bmatrix} 
u_{11} & \cdots & u_{1n} \\ & ⋱ & ⋮\\
                                        && u_{nn}\end{bmatrix}}_U
$$
i.e.
$$
A = \underbrace{L_{1}^{-1} \cdots L_{n-1}^{-1}}_L U.
$$

Writing
$$
L_j = I + \begin{bmatrix} 𝟎_j \\ \ell_{j+1,j} \\ ⋮ \\ \ell_{n,j} \end{bmatrix} 𝐞_j^\top
$$
and using the properties of inversion and multiplication we therefore deduce
$$
L = \begin{bmatrix} 1 \\ -\ell_{21} & 1 \\
-\ell_{31} & -\ell_{32} & 1 \\
 ⋮ & ⋮ & ⋱ & ⋱ \\
    -\ell_{n1} & -\ell_{n2} & \cdots & -\ell_{n,n-1} & 1
    \end{bmatrix}
$$




**<span style="color:#008080">Example</span> (computer)**
We will do a numerical example (by-hand is equivalent to Gaussian elimination).
The first lower triangular matrix is:
```julia
n = 4
A = randn(n,n)
L₁ = I -[0; A[2:end,1]/A[1,1]] * [1 zeros(1,n-1)]
```
Which indeed introduces zeros in the first column:
```julia
A₁ = L₁*A
```
Now we make the next lower triangular operator:
```julia
L₂ = I - [0; 0; A₁[3:end,2]/A₁[2,2]] * [0 1 zeros(1,n-2)]
```
So that
```julia
A₂ = L₂*L₁*A
```
The last one is:
```julia
L₃ = I - [0; 0; 0; A₂[4:end,3]/A₂[3,3]] * [0 0 1 zeros(1,n-3)]
```
Giving us
```julia
U = L₃*L₂*L₁*A
```
and
```julia
L = inv(L₁)*inv(L₂)*inv(L₃)
```
Note how the entries of `L` are indeed identical to the negative
lower entries of `L₁`, `L₂` and `L₃`.

**<span style="color:#008080">Example</span> (by-hand)**

Consider the matrix
$$
A = \begin{bmatrix} 1 & 1 & 1 \\
                    2 & 4 & 8 \\
                    1 & 4 & 9
                    \end{bmatrix}
$$
We have
$$
L_2 L_1 A = L_2 \begin{bmatrix}1 \\ 
                        -2 & 1 \\ -1 &  & 1 \end{bmatrix} \begin{bmatrix} 1 & 1 & 1 \\
                    2 & 4 & 8 \\
                    1 & 4 & 9
                    \end{bmatrix}
    = \begin{bmatrix}1 \\ & 1\\ & -{3 \over 2} & 1 
    \end{bmatrix} \begin{bmatrix} 1 & 1 & 1 \\
                         & 2 & 6 \\
                         & 3 & 8 \end{bmatrix}
    = \underbrace{\begin{bmatrix} 1 & 1 & 1 \\
                         & 2 & 6 \\
                         &  & -1 \end{bmatrix}}_U
$$
We then deduce $L$ by taking the negative of the lower 
entries of $L_1,L_2$:
$$
L = \begin{bmatrix} 1 \\ 2 & 1 \\ 1 &{3 \over 2} & 1
\end{bmatrix}.
$$


#### PLU Decomposition

We learned in first year linear algebra that if a diagonal entry is zero
when doing Gaussian elimnation one has to _row pivot_. For stability, 
in implementation one _always_ pivots: swap the largest in magnitude entry for the entry on the diagonal.
In terms of a decomposition, this leads to 
$$
L_{n-1} P_{n-1} \cdots P_2 L_1 P_1 A = U
$$
where $P_j$ is a permutation that leaves rows 1 through $j-1$ fixed,
and swaps row $j$ with a row $k \geq j$ whose entry is maximal in absolute value.

Thus we can deduce that 
$$
L_{n-1} P_{n-1} \cdots P_2 L_1 P_1 = \underbrace{L_{n-1} \tilde L_{n-2} \cdots  \tilde L_1}_{L^{-1}}  \underbrace{P_{n-1} \cdots P_2 P_1}_P.
$$
where the tilde denotes the combined actions of swapping the permutation and lower-triangular matrices, that is,
$$
P_{n-1}\cdots P_{j+1} L_j = \tilde L_j P_{n-1}\cdots P_{j+1}.
$$
where $\tilde L_j \in {\cal L}_j$.
The entries of $L$ are then again the negative of the entries below the diagonal of $L_{n-1}, \tilde L_{n-2}, \ldots,\tilde L_1$.


Writing
$$
\tilde L_j = I + \begin{bmatrix} 𝟎_j \\ \tilde \ell_{j+1,j} \\ ⋮ \\ \tilde \ell_{n,j} \end{bmatrix} 𝐞_j^\top
$$
and using the properties of inversion and multiplication we therefore deduce
$$
L = \begin{bmatrix} 
1 \\ 
-\tilde \ell_{21} & 1 \\
-\tilde \ell_{31} & -\tilde \ell_{32} & 1 \\
 ⋮ & ⋮ & ⋱ & ⋱ \\
 -\tilde \ell_{n-1,1} & -\tilde \ell_{n-1,2} & \cdots &  - \tilde \ell_{n-1,n-2} & 1 \\
    -\tilde \ell_{n1} & -\tilde \ell_{n2} & \cdots &  - \tilde \ell_{n,n-2} &  -\ell_{n,n-1} & 1
\end{bmatrix}
$$



**<span style="color:#008080">Example</span>**

Again we consider the matrix
$$
A = \begin{bmatrix} 1 & 1 & 1 \\
                    2 & 4 & 8 \\
                    1 & 4 & 9
                    \end{bmatrix}
$$
Even though $a_{11} = 1 \neq 0$, we still pivot: placing 
the maximum entry on the diagonal to mitigate numerical errors.
That is, we first pivot and upper triangularise the first column:
$$
 L_1 P_1 A =  L_1\begin{bmatrix} 0 & 1 \\ 1 & 0 \\ && 1 \end{bmatrix}
\begin{bmatrix} 1 & 1 & 1 \\
                    2 & 4 & 8 \\
                    1 & 4 & 9
                    \end{bmatrix} = 
                     \begin{bmatrix}1 \\ -{1 \over 2} & 1 \\ -{1 \over 2} && 1 \end{bmatrix}
\begin{bmatrix} 2 & 4 & 8 \\
                1 & 1 & 1 \\
                    1 & 4 & 9
                    \end{bmatrix}
$$
We now pivot and upper triangularise the second column:
$$
  L_2 P_2 L_1 P_1 A = 
                    L_2 \begin{bmatrix}
                    1 \\ &0 & 1 \\ &1 & 0 \end{bmatrix}
\begin{bmatrix} 2 & 4 & 8 \\
                0 & -1 & -3 \\
                    0 & 2 & 5
                    \end{bmatrix}
                    = \begin{bmatrix} 1\\ & 1 \\ & {1 \over 2} & 1 \end{bmatrix}
\begin{bmatrix} 2 & 4 & 8 \\
                0 & 2 & 5 \\
                0 & -1 & -3 
                    \end{bmatrix} = 
                    \underbrace{\begin{bmatrix} 2 & 4 & 8 \\
                0 & 2 & 5 \\
                0 & 0 & -{1 \over 2}
                    \end{bmatrix}}_U
$$
We now move $P_2$ to the right:
$$
L_2 P_2 L_1 P_1 = \underbrace{\begin{bmatrix} 1\\ -{1 \over 2} & 1 \\  -{1 \over 2}  & {1 \over 2} & 1 \end{bmatrix}}_{L_2 \tilde L_1} \underbrace{\begin{bmatrix} 0 & 1 & 0 \\ 0 & 0 & 1 \\ 1 & 0 & 0 \end{bmatrix}}_P
$$
That is
$$
L = \begin{bmatrix} 1\\ {1 \over 2} & 1 \\  {1 \over 2}  & -{1 \over 2} & 1 \end{bmatrix}
$$

We see how this example is done on a computer:
```julia
A = [1 1 1;
     2 4 8;
     1 4 9]
L,U,σ = lu(A) # σ is a vector encoding the permutation
```
The permutation is $\sigma$.
Thus to invert a system we can do:

```julia
b = randn(3)
U\(L\b[σ]) == A\b
```
Note the entries match exactly because this precisely what `\ ` is using.

### 3. Cholesky Decomposition

Cholesky Decomposition is a form of Gaussian elimination (without pivoting)
that exploits symmetry in the problem, resulting in a substantial speedup. 
It is only relevant for _symmetric positive definite_
matrices.

>**Definition (positive definite)** A square matrix $A \in ℝ^{n × n}$ is _positive definite_ if
>for all $𝐱 \in ℝ^n, x \neq 0$ we have
>$$
>𝐱^\top A 𝐱 > 0
>$$

First we establish some basic properties of positive definite matrices:

>**Proposition (conj. pos. def.)** If  $A \in ℝ^{n × n}$ is positive definite and 
>$V \in ℝ^{n × n}$ is non-singular then
>$$
>V^\top A V
>$$
>is positive definite.

>**Proposition (diag positivity)** If $A \in ℝ^{n × n}$ is positive definite
>then its diagonal entries are positive: $a_{kk} > 0$.


>**Theorem (subslice pos. def.)** If $A \in ℝ^{n × n}$ is positive definite
>and $𝐤 \in \{1,\ldots,n\}^m$ is a vector of $m$ integers where any integer appears only once,
> then $A[𝐤,𝐤] ∈ ℝ^{m × m}$ is also
>positive definite.



We leave the proofs to the problem sheets. Here is the key result:


>**Theorem (Cholesky and sym. pos. def.)** A matrix $A$ is symmetric positive definite if and only if it has a Cholesky decomposition
>$$
>A = L L^⊤
>$$
>where the diagonals of $L$ are positive.

==**Proof**== If $A$ has a Cholesky decomposition it is symmetric ($A^⊤ = (L L^⊤)^⊤ = A$) and for $𝐱 ≠ 0$ we have
$$
𝐱^⊤ A 𝐱 = (L𝐱)^⊤ L 𝐱 = \|L𝐱\|^2 > 0
$$
where we use the fact that $L$ is non-singular.

For the other direction we will prove it by induction, with the $1 × 1$ case being trivial. 
Write
$$
A = \begin{bmatrix} α & 𝐯^\top \\
                    𝐯   & K
                    \end{bmatrix} = \underbrace{\begin{bmatrix} \sqrt{α} \\ 
                                    {𝐯 \over \sqrt{α}} & I \end{bmatrix}}_{L_1}
                                    \underbrace{\begin{bmatrix} 1  \\ & K - {𝐯 𝐯^\top \over α} \end{bmatrix}}_{A_1}
                                    \underbrace{\begin{bmatrix} \sqrt{α} & {𝐯^\top \over \sqrt{α}} \\
                                     & I \end{bmatrix}}_{L_1^\top}.
$$
Note that $K - {𝐯 𝐯^\top \over α}$ is a subslice of $A_1 = L_1^{-1} A L_1^{-⊤}$, hence by the previous propositions is
itself symmetric positive definite. Thus we can write 
$$
K - {𝐯 𝐯^\top \over α} = \tilde L \tilde L^⊤
$$
and hence $A = L L^⊤$ for
$$
L= L_1 \begin{bmatrix}1 \\ & \tilde L \end{bmatrix}.
$$
satisfies $A = L L^⊤$.



Note hidden in this proof is a simple algorithm form computing the Cholesky decomposition.
We define
$$
\begin{align*}
A_1 &:= A \\
𝐯_k &:= A_k[2:n-k+1,1] \\
α_k &:= A_k[1,1] \\
A_{k+1} &:= A_k[2:n-k+1,2:n-k+1] - {𝐯_k 𝐯_k^⊤ \over α_k}.
\end{align*}
$$
Then
$$
L = \begin{bmatrix} \sqrt{α_1} \\
    {𝐯_1[1] \over \sqrt{α_1}}  &  \sqrt{α_2} \\
    {𝐯_1[2] \over \sqrt{α_1}}  & {𝐯_2[1] \over \sqrt{α_2}} &  \sqrt{α_2} \\
    ⋮ & ⋮ & ⋱ & ⋱ \\
    {𝐯_1[n-1] \over \sqrt{α_1}} &{𝐯_2[n-2] \over \sqrt{α_2}} & ⋯ & {𝐯_{n-1}[1] \over \sqrt{α_{n-1}}} & \sqrt{α_{n}}
    \end{bmatrix}
$$

This algorithm succeeds if and only if $A$ is symmetric positive definite.

**<span style="color:#008080">Example</span>** Consider the matrix
$$
A_0 = A = \begin{bmatrix}
2 &1 &1 &1 \\
1 & 2 & 1 & 1 \\
1 & 1 & 2 & 1 \\
1 & 1 & 1 & 2
\end{bmatrix}
$$
Then
$$
A_1 = \begin{bmatrix}
2 &1 &1 \\
1 & 2 & 1 \\
1 & 1 & 2 
\end{bmatrix} - {1 \over 2} \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix} \begin{bmatrix} 1 & 1 & 1 \end{bmatrix} =
{1 \over 2} \begin{bmatrix}
3 & 1 & 1 \\
1 & 3 & 1 \\
1 & 1 & 3 
\end{bmatrix}
$$
Continuing, we have 
$$
A_2 = {1 \over 2} \left( \begin{bmatrix}
3 & 1 \\ 1 & 3
\end{bmatrix} - {1 \over 3} \begin{bmatrix} 1 \\ 1  \end{bmatrix} \begin{bmatrix} 1 & 1  \end{bmatrix}
\right)
= {1 \over 3} \begin{bmatrix} 4 & 1 \\ 1 & 4 \end{bmatrix}
$$
Finally
$$
A_3 = {5 \over 4}.
$$
Thus we get
$$
L= L_1 L_2 L_3 = \begin{bmatrix} \sqrt{2} \\ {1 \over \sqrt{2}} & {\sqrt{3} \over 2} \\ 
{1 \over \sqrt{2}} & {1 \over \sqrt 6} & {2 \over \sqrt{3}} \\
{1 \over \sqrt{2}} & {1 \over \sqrt 6} & {1 \over \sqrt{12}} & {\sqrt{5} \over 2}
\end{bmatrix}
$$


### 4. Timings

The different decompositions have trade-offs between speed and stability.
First we compare the speed of the different decompositions on a symmetric positive
definite matrix, from fastest to slowest:

```julia
n = 100
A = Symmetric(rand(n,n)) + 100I # shift by 10 ensures positivity
@btime cholesky(A);
@btime lu(A);
@btime qr(A);
```
On my machine, `cholesky` is ~1.5x faster than `lu`,  
which is ~2x faster than QR. 



In terms of stability, QR computed with Householder reflections
(and Cholesky for positive definite matrices) are stable, 
whereas LU is usually unstable (unless the matrix
is diagonally dominant). PLU is a very complicated story: in theory it is unstable,
but the set of matrices for which it is unstable is extremely small, so small one does not
normally run into them.

Here is an example matrix that is in this set. 
```julia
function badmatrix(n)
    A = Matrix(1I, n, n)
    A[:,end] .= 1
    for j = 1:n-1
        A[j+1:end,j] .= -1
    end
    A
end
A = badmatrix(5)
```
Note that pivoting will not occur (we do not pivot as the entries below the diagonal are the same magnitude as the diagonal), thus the PLU Decomposition is equivalent to an LU decomposition:
```julia
L,U = lu(A)
```
But here we see an issue: the last column of `U` is growing exponentially fast! Thus when `n` is large
we get very large errors:
```julia
n = 100
b = randn(n)
A = badmatrix(n)
norm(A\b - qr(A)\b) # A \ b still uses lu
```
Note `qr` is completely fine:
```julia
norm(qr(A)\b - qr(big.(A)) \b) # roughly machine precision
```

Amazingly, PLU is fine if applied to a small perturbation of `A`:
```julia
ε = 0.000001
Aε = A .+ ε .* randn.()
norm(Aε \ b - qr(Aε) \ b) # Now it matches!
```



The big _open problem_ in numerical linear algebra is to prove that the set of matrices
for which PLU fails has extremely small measure.


-----------------------------------------------------------------

## Singular values and conditioning
>**YouTube Lectures:**
>[Matrix Norms](https://www.youtube.com/watch?v=aRxWAF3lhyY)
>[Singular Value Decomposition](https://www.youtube.com/watch?v=CPrRo-4snlg)

In this lecture we discuss matrix and vector norms. The matrix $2$-norm involves
_singular values_, which are a measure of how matrices "stretch" vectors. 
We also show that
the singular values of a matrix give a notion of a _condition number_, which allows us
to bound errors introduced by floating point numbers in linear algebra operations.

1. Vector norms: we discuss the standard $p$-norm for vectors in $ℝ^n$.
2. Matrix norms: we discuss how two vector norms can be used to induce a norm on matrices. These
satisfy an additional multiplicative inequality.
3. Singular value decomposition: we introduce the singular value decomposition which is related to
the matrix $2$-norm and best low rank approximation.
4. Condition numbers: we will see how errors in matrix-vector multiplication and solving linear systems
can be bounded in terms of the _condition number_, which is defined in terms of singular values.

```julia
using LinearAlgebra, Plots
```

### 1. Vector norms

Recall the definition of a (vector-)norm:

>**Definition (vector-norm)** A norm $\|\cdot\|$ on $ℝ^n$ is a function that satisfies the following, for $𝐱,𝐲 ∈ ℝ^n$ and
>$c ∈ ℝ$:
>1. Triangle inequality: $\|𝐱 + 𝐲 \| ≤ \|𝐱\| + \|𝐲\|$
>2. Homogeneity: $\| c 𝐱 \| = |c| \| 𝐱 \|$
>3. Positive-definiteness: $\|𝐱\| = 0$ implies that $𝐱 = 0$.


Consider the following example:

>**Definition (p-norm)**
>For $1 ≤ p < ∞$ and $𝐱 \in ℝ^n$, define the $p$-norm:
>$$
>\|𝐱\|_p := \left(\sum_{k=1}^n |x_k|^p\right)^{1/p}
>$$
>where $x_k$ is the $k$-th entry of $𝐱$. 
>For $p = ∞$ we define
>$$
>\|𝐱\|_∞ := \max_k |x_k|
>$$

>**Theorem (p-norm)** $\| ⋅ \|_p$ is a norm for $1 ≤ p ≤ ∞$.

==**Proof**==

We will only prove the case $p = 1, 2, ∞$ as general $p$ is more involved.

Homogeneity and positive-definiteness are straightforward: e.g.,
$$
\|c 𝐱\|_p = (\sum_{k=1}^n |cx_k|^p)^{1/p} = (|c|^p \sum_{k=1}^n |x_k|^p)^{1/p} = |c| \| 𝐱 \|
$$
and if $\| 𝐱 \|_p = 0$ then all $|x_k|^p$ are have to be zero.

For $p = 1,∞$ the triangle inequality is also straightforward:
$$
\| 𝐱 + 𝐲 \|_∞ = \max_k (|x_k + y_k|) ≤ \max_k (|x_k| + |y_k|) ≤ \|𝐱\|_∞ + \|𝐲\|_∞
$$
and
$$
\| 𝐱 + 𝐲 \|_1 = \sum_{k=1}^n |x_k + y_k| ≤  \sum_{k=1}^n (|x_k| + |y_k|) = \| 𝐱 \|_1 + \| 𝐲\|_1
$$

For $p = 2$ it can be proved using the Cauchy–Schwartz inequality:
$$
|𝐱^⊤ 𝐲| ≤ \| 𝐱 \|_2 \| 𝐲 \|_2
$$
That is, we have
$$
\| 𝐱 + 𝐲 \|^2 = \|𝐱\|^2 + 2 𝐱^⊤ 𝐲 + \|𝐲\|^2 ≤ \|𝐱\|^2 + 2\| 𝐱 \| \| 𝐲 \| + \|𝐲\|^2 = (\| 𝐱 \| +  \| 𝐲 \|)
$$





 In Julia, one can use the inbuilt `norm` function to calculate norms:
 ```julia
 norm([1,-2,3]) == norm([1,-2,3], 2) == sqrt(1^2 + 2^2 + 3^2);
 norm([1,-2,3], 1) == sqrt(1 + 2 + 3);
 norm([1,-2,3], Inf) == 3;
 ```


### 2. Matrix norms
 Just like vectors, matrices have norms that measure their "length".  The simplest example is the Fröbenius norm, 
 defined for an $m \times n$ real matrix $A$ as
$$
\|A\|_F := \sqrt{\sum_{k=1}^m \sum_{j=1}^n A_{kj}^2}
$$
This is available as `norm` in Julia:
```julia
A = randn(5,3)
norm(A) == norm(vec(A))
```

While this is the simplest norm, it is not the most useful.  Instead, we will build a matrix norm from a 
vector norm:



>**Definition (matrix-norm)** Suppose $A ∈ ℝ^{m × n}$  and consider two norms $\| ⋅ \|_X$ on $ℝ^n$  and 
>$\| ⋅ \|_Y$ on $ℝ^n$. Define the _(induced) matrix norm_ as:
>$$
>\|A \|_{X → Y} := \sup_{𝐯 : \|𝐯\|_X=1} \|A 𝐯\|_Y
>$$
>Also define
>$$
>\|A\|_X \triangleq \|A\|_{X \rightarrow X}
>$$

For  the induced 2, 1, and $∞$-norm we use
$$
\|A\|_2, \|A\|_1 \qquad \hbox{and} \qquad \|A\|_∞.
$$

Note an equivalent definition of the induced norm:
$$
\|A\|_{X → Y} = \sup_{𝐱 ∈ ℝ^n, 𝐱 ≠ 0} {\|A 𝐱\|_Y \over \| 𝐱\|_X}
$$
This follows since we can scale $𝐱$ by its norm so that it has unit norm, that is,
${𝐱} \over \|𝐱\|_X$ has unit norm.

>**Lemma (matrix norms are norms)** Induced matrix norms are norms, that is for $\| ⋅ \| = \| ⋅ \|_{X → Y}$ we have:
>1. Triangle inequality: $\| A + B \| ≤  \|A\| + \|B\|$
>1. Homogeneneity: $\|c A \| = |c| \|A\|$
>3. Positive-definiteness: $\|A\| =0 \Rightarrow A = 0$

In addition, they satisfy the following additional properties:
1. $\|A 𝐱 \|_Y ≤ \|A\|_{X → Y} \|𝐱 \|_X$
2. Multiplicative inequality: $\| AB\|_{X → Z} ≤ \|A \|_{Y → Z} \|B\|_{X →  Y}$

==**Proof**==

First we show the _triangle inequality_:
$$
\|A + B \| ≤ \sup_{𝐯 : \|𝐯\|_X=1} (\|A 𝐯\|_Y + \|B 𝐯\|_Y) ≤ \| A \| + \|B \|.
$$
Homogeneity is also immediate. Positive-definiteness follows from the fact that if
$\|A\| = 0$ then $A 𝐱  = 0$ for all $𝐱 ∈ ℝ^n$.
The property $\|A 𝐱 \|_Y ≤ \|A\|_{X → Y} \|𝐱 \|_X$ follows from the definition.
Finally, the multiplicative inequality follows from
$$
\|A B\| = \sup_{𝐯 : \|𝐯\|_X=1} \|A B 𝐯 |_Z ≤ \sup_{𝐯 : \|𝐯\|_X=1} \|A\|_{Y → Z} \| B 𝐯 | = \|A \|_{Y → Z} \|B\|_{X →  Y}
$$





We have some simple examples of induced norms:

**<span style="color:#008080">Example</span> ($1$-norm)** We claim 
$$
\|A \|_1 = \max_j \|𝐚_j\|_1
$$
that is, the maximum $1$-norm of the columns. To see this use the triangle inequality to
find for $\|𝐱\|_1 = 1$
$$
\| A 𝐱 \|_1 ≤ ∑_{j = 1}^n |x_j| \| 𝐚_j\|_1 ≤ \max_j \| 𝐚_j\| ∑_{j = 1}^n |x_j| = \max_j \| 𝐚_j\|_1.
$$
But the bound is also attained since if $j$ is the column that maximises the norms then
$$
\|A 𝐞_j \|_1 = \|𝐚_j\|_1 =  \max_j \| 𝐚_j\|_1.
$$

In the problem sheet we see that
$$
\|A\|_∞ = \max_k \|A[k,:]\|_1
$$
that is, the maximum $1$-norm of the rows.

Matrix norms are available via `opnorm`:
```julia
m,n = 5,3
A = randn(m,n)
opnorm(A,1) == maximum(norm(A[:,j],1) for j = 1:n)
opnorm(A,Inf) == maximum(norm(A[k,:],1) for k = 1:m)
opnorm(A) # the 2-norm
```


An example that does not have a simple formula is $\|A \|_2$, but we do have two simple cases:

>**Proposition (diagonal/orthogonal 2-norms)** If $Λ$ is diagonal with entries $λ_k$ then
>$\|Λ\|_2 = \max_k |λ_k|.$. If $Q$ is orthogonal then $\|Q\| = 1$.


### 3. Singular value decomposition

To define the induced $2$-norm we need to consider the following:

>**Definition (singular value decomposition)** For $A ∈ ℝ^{m × n}$ with rank $r > 0$, 
>the _reduced singular value decomposition (SVD)_ is
>$$
>A = U Σ V^⊤
>$$
>where $U ∈ ℝ^{m × r}$ and $V ∈  ℝ^{r × n}$ have orthonormal columns and $Σ ∈ ℝ^{r × r}$ is  diagonal whose
>diagonal entries, which which we call _singular values_, are all positive and decreasing: $σ_1 ≥ ⋯ ≥ σ_r > 0$.
>The _full singular value decomposition (SVD)_ is
>$$
>A = Ũ Σ̃ Ṽ^⊤
>$$
>where $Ũ ∈ ℝ^{m × m}$ and $Ṽ ∈  ℝ^{n × n}$ are orthogonal matrices and $Σ̃ ∈ ℝ^{m × n}$ has only
>diagonal entries, i.e., if $m > n$,
>$$
>Σ̃ = \begin{bmatrix} σ_1 \\ & ⋱ \\ && σ_n \\ && 0 \\ && ⋮ \\ && 0 \end{bmatrix}
>$$
>and if $m < n$,
>$$
>Σ̃ = \begin{bmatrix} σ_1 \\ & ⋱ \\ && σ_m & 0 & ⋯ & 0\end{bmatrix}
>$$
>where $σ_k = 0$ if $k > r$.

To show the SVD exists we first establish some properties of a _Gram matrix_ ($A^⊤A$):

>**Proposition (Gram matrix kernel)** The kernel of $A$ is the also the kernel of $A^⊤ A$. 

==**Proof**==
If $A^⊤ A 𝐱 = 0$ then we have
$$
0 = 𝐱^T A^⊤ A 𝐱 = \| A 𝐱 \|^2
$$
which means $A 𝐱 = 0$ and $𝐱 ∈ \hbox{ker}(A)$.


>**Proposition (Gram matrix diagonalisation)** The Gram-matrix
>satisfies
>$$
>A^⊤ A = Q Λ Q^⊤
>$$
>where $Q$ is orthogonal and the eigenvalues $λ_k$ are non-negative.

==**Proof**==
$A^⊤ A$ is symmetric so we appeal to the spectral theorem for the
existence of the decomposition.
For the corresponding (orthonormal) eigenvector $𝐪_k$,
$$
λ_k = λ_k 𝐪_k^⊤ 𝐪_k = 𝐪_k^⊤ A^⊤ A 𝐪_k = \| A 𝐪_k \|^2 ≥ 0.
$$




This connection allows us to prove existence:

>**Theorem (SVD existence)** Every $A ∈ ℝ^{m × n}$ has an SVD.

==**Proof**==
Consider
$$
A^⊤ A = Q Λ Q^⊤.
$$
Assume (as usual) that the eigenvalues are sorted in decreasing modulus, and so $λ_1,…,λ_r$
are an enumeration of the non-zero eigenvalues and
$$
V := \begin{bmatrix} 𝐪_1 | ⋯ | 𝐪_r \end{bmatrix}
$$
the corresponding (orthonormal) eigenvectors, with
$$
K = \begin{bmatrix} 𝐪_{r+1} | ⋯ | 𝐪_n \end{bmatrix}
$$
the corresponding kernel. 
Define
$$
Σ :=  \begin{bmatrix} \sqrt{λ_1} \\ & ⋱ \\ && \sqrt{λ_r} \end{bmatrix}
$$
Now define
$$
U := AV Σ^{-1}
$$
which is orthogonal since $A^⊤ A V = V Σ^2 $:
$$
U^⊤ U = Σ^{-1} V^⊤ A^⊤ A V Σ^{-1} = I.
$$
Thus we have
$$
U Σ V^⊤ = A V V^⊤ = A \underbrace{\begin{bmatrix} V | K \end{bmatrix}}_Q\underbrace{\begin{bmatrix} V^⊤ \\ K^⊤ \end{bmatrix}}_{Q^⊤}
$$
where we use the fact that $A K = 0$ so that concatenating $K$ does not change the value.



Singular values tell us the 2-norm:

>**Corollary (singular values and norm)**
>$$
>\|A \|_2 = σ_1
>$$
>and if $A ∈ ℝ^{n × n}$ is invertible, then
>$$
>\|A^{-1} \|_2 = σ_n^{-1}
>$$

==**Proof**==

First we establish the upper-bound:
$$
\|A \|_2 ≤  \|U \|_2 \| Σ \|_2 \| V^⊤\|_2 = \| Σ \|_2  = σ_1
$$
This is attained using the first right singular vector:
$$
\|A 𝐯_1\|_2 = \|Σ V^⊤ 𝐯_1\|_2 = \|Σ  𝐞_1\|_2 = σ_1
$$
The inverse result follows since the inverse has SVD
$$
A^{-1} = V Σ^{-1} U^⊤ = V (W Σ^{-1} W) U^⊤
$$
is the SVD of $A^{-1}$, where
$$
W := P_σ = \begin{bmatrix} && 1 \\ & ⋰ \\ 1 \end{bmatrix}
$$
is the permutation that reverses the entries, that is, $σ$ has Cauchy notation
$$
\begin{pmatrix}
1 & 2 & ⋯ & n \\
n & n-1 & ⋯ & 1
\end{pmatrix}.
$$




We will not discuss in this module computation of singular value decompositions or eigenvalues:
they involve iterative algorithms (actually built on a sequence of QR decompositions).

One of the main usages for SVDs is low-rank approximation:

>**Theorem (best low rank approximation)** The  matrix
>$$
>A_k := \begin{bmatrix} 𝐮_1 | ⋯ | 𝐮_k \end{bmatrix} \begin{bmatrix}
>σ_1 \\
>& ⋱ \\
>&& σ_k\end{bmatrix} \begin{bmatrix} 𝐯_1 | ⋯ | 𝐯_k \end{bmatrix}^⊤
>$$
>is the best 2-norm approximation of $A$ by a rank $k$ matrix, that is, for all rank-$k$ matrices $B$, we have 
>$$\|A - A_k\|_2 ≤ \|A -B \|_2.$$


==**Proof**==
We have

$$
A - A_k = U \begin{bmatrix} 0  \cr &\ddots \cr && 0 \cr &&& σ_{k+1} \cr &&&& \ddots \cr &&&&& σ_r\end{bmatrix} V^⊤.
$$
Suppose a rank-$k$ matrix $B$ has 
$$
\|A-B\|_2  < \|A-A_k\|_2 = σ_{k+1}.
$$
For all $𝐰 \in \ker(B)$ we have 
$$
\|A 𝐰\|_2 = \|(A-B) 𝐰\|_2 ≤ \|A-B\|\|𝐰\|_2  < σ_{k+1} \|𝐰\|_2
$$

But for all $𝐮 \in {\rm span}(𝐯_1,…,𝐯_{k+1})$, that is, $𝐮 = V[:,1:k+1]𝐜$ for some $𝐜 \in ℝ^{k+1}$  we have 
$$
\|A 𝐮\|_2^2 = \|U Σ_k 𝐜\|_2^2 = \|Σ_k 𝐜\|_2^2 =
\sum_{j=1}^{k+1} (σ_j c_j)^2 ≥ σ_{k+1}^2 \|c\|^2,
$$
i.e., $\|A 𝐮\|_2 ≥ σ_{k+1} \|c\|$.  Thus $𝐰$ cannot be in this span.


The dimension of the span of $\ker(B)$ is at least $n-k$, but the dimension of ${\rm span}(𝐯_1,…,𝐯_{k+1})$ is at least $k+1$.
Since these two spaces cannot intersect we have a contradiction, since $(n-r) + (r+1) = n+1 > n$.  



Here we show an example of a simple low-rank approximation using the SVD. Consider the Hilbert matrix:
```julia
function hilbertmatrix(n)
    ret = zeros(n,n)
    for j = 1:n, k=1:n
        ret[k,j] = 1/(k+j-1)
    end
    ret
end
hilbertmatrix(5)
```
That is, the $H[k,j] = 1/(k+j-1)$. This is a famous example of matrix with rapidly decreasing singular values:
```julia
H = hilbertmatrix(100)
U,σ,V = svd(H)
scatter(σ; yscale=:log10)
```
Note numerically we typically do not get a exactly zero singular values so the rank is always
treated as $\min(m,n)$.
Because the singular values decay rapidly 
 we can approximate the matrix very well with a rank 20 matrix:
```julia
k = 20 # rank
Σ_k = Diagonal(σ[1:k])
U_k = U[:,1:k]
V_k = V[:,1:k]
norm(U_k * Σ_k * V_k' - H)
```

Note that this can be viewed as a _compression_ algorithm: we have replaced a matrix with 
$100^2 = 10,000$ entries by two matrices and a vector with $4,000$ entries without losing
any information.
In the problem sheet we explore the usage of low rank approximation to smooth functions.



### 4. Condition numbers

We have seen that floating point arithmetic induces errors in computations, and that we can typically
bound the absolute errors to be proportional to $C ϵ_{\rm m}$. We want a way to bound the
effect of more complicated calculations like computing $A 𝐱$ or $A^{-1} 𝐲$ without having to deal with
the exact nature of floating point arithmetic. Here we consider only matrix-multiplication but will make a remark
about matrix inversion.

To justify what follows, we first observe that errors in implementing matrix-vector multiplication
can be captured by considering the multiplication to be exact on the wrong matrix: that is, `A*x`
(implemented with floating point) is precisely $A + δA$ where $δA$ has small norm, relative to $A$.
This is known as _backward error analysis_.



To discuss floating point errors we need to be precise which order the operations happened.
We will use the definition `mul(A,x)`, which denote ${\rm mul}(A, 𝐱)$. (Note that `mul_rows` actually
does the _exact_ same operations, just in a different order.) Note that each entry of the result is in fact a dot-product
of the corresponding rows so we first consider the error in the dot product  `dot(𝐱,𝐲)` as implemented in floating-point, 
which we denote ${\rm dot}(A,x)$.

We first need a helper proposition:

>**Proposition** If $|ϵ_i| ≤ ϵ$ and $n ϵ < 1$, then
>$$
>\prod_{k=1}^n (1+ϵ_i) = 1+θ_n
>$$
>for some constant $θ_n$ satisfying $|θ_n| ≤ {n ϵ \over 1-nϵ}$.

The proof is left as an exercise (Hint: use induction).

>**Lemma (dot product backward error)**
>For $𝐱, 𝐲 ∈ ℝ^n$,
>$$
>{\rm dot}(𝐱, 𝐲) = (𝐱 + δ𝐱)^⊤ 𝐲
>$$
>where
>$$
>|δ𝐱| ≤  {n ϵ_{\rm m} \over 2-nϵ_{\rm m}} |𝐱 |,
>$$
>where $|𝐱 |$ means absolute-value of each entry.


==**Proof**==

Note that 
$$
\begin{align*}
{\rm dot}(𝐱, 𝐲) &= \{ [(x_1 ⊗ y_1) ⊕ (x_2 ⊗ y_2)] ⊕(x_3⊗ y_3)] ⊕⋯\}⊕(x_n ⊗ y_n) \\
  & = \{ [(x_1 y_1)(1+δ_1) + (x_2 y_2)(1+δ_2)](1+γ_2)  \\&+ x_3 y_3(1+δ_3)](1+γ_3) + ⋯  +x_n y_n(1+δ_n) \}(1+γ_n) \\
  & = ∑_{j = 1}^n x_j y_j (1+δ_j) ∏_{k=j}^n (1 + γ_k) \\
  & = ∑_{j = 1}^n x_j y_j (1+θ_j)
\end{align*}
$$
where we denote the errors from multiplication as $δ_k$ and those from addition by $γ_k$ 
(with $γ_1 = 0$). Note that $θ_j$ each have at most $n$ terms each bounded by $ϵ_{\rm m}/2$,
Thus the previous proposition tells us
$$
|θ_j| ≤ {n ϵ_{\rm m} \over 2- nϵ_{\rm m}}.
$$
Thus
$$
δ𝐱 =  \begin{pmatrix} x_1 θ_n^1 \cr x_2 θ_n^2 \cr x_3 θ_{n-1} \cr \vdots \cr x_n θ_1\end{pmatrix}
$$
and the theorem follows from homogeneity:
$$
\| δ𝐱 \| ≤ {n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \| 𝐱 \|
$$



>**Theorem (matrix-vector backward error)**
>For $A ∈ ℝ^{m × n}$ and $𝐱 ∈ ℝ^n$ we have
>$$
>{\rm mul}(A, 𝐱) = (A + δA) 𝐱
>$$
>where
>$$
>|δA| ≤ {n ϵ_{\rm m} \over 2-nϵ_{\rm m}}  |A|.
>$$
>Therefore
>$$
>\begin{align*}
>\|δA\|_1 &≤  {n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \|A \|_1 \\
>\|δA\|_2 &≤  {\sqrt{\min(m,n)} n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \|A \|_2 \\
>\|δA\|_∞ &≤  {n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \|A \|_∞
>\end{align*}
>$$

==**Proof**==
The bound on $|δA|$ is implied by the previous lemma.
The $1$ and $∞$-norm follow since
$$
\|A\|_1 = \||A|\|_1 \hbox{ and } \|A\|_∞ = \||A|\|_∞
$$
This leaves the 2-norm example, which is a bit more challenging as there are matrices
$A$ such that $\|A\|_2 ≠ \| |A| \|_2$.
Instead we will prove the result by going through the Fröbenius norm and using:
$$
\|A \|_2 ≤ \|A\|_F ≤ \sqrt{r} \| A\|_2
$$
where $r$ is rank of $A$ (see PS5)
and $\|A\|_F = \| |A| \|_F$,
so we deduce:
$$
\begin{align*}
\|δA \|_2 &≤ \| δA\|F = \| |δA| \|F ≤ {n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \| |A| \|_F \\
          &= {n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \| A \|_F ≤ {\sqrt{r} n ϵ_{\rm m} \over 2-nϵ_{\rm m}}\| A \|_2 \\
          &≤ {\sqrt{\min(m,n)} n ϵ_{\rm m} \over 2-nϵ_{\rm m}} \|A \|_2
\end{align*}
$$



So now we get to a mathematical question independent of floating point: 
can we bound the _relative error_ in approximating
$$
A 𝐱 ≈ (A + δA) 𝐱
$$
if we know a bound on $\|δA\|$?
It turns out we can in turns of the _condition number_ of the matrix:

>**Definition (condition number)**
>For a square matrix $A$, the _condition number_ (in $p$-norm) is
>$$
>κ_p(A) := \| A \|_p \| A^{-1} \|_p
>$$
>with the $2$-norm:
>$$
>κ_2(A) = {σ_1 \over σ_n}.
>$$


>**Theorem (relative-error for matrix-vector)**
>The _worst-case_ relative error in $A 𝐱 ≈ (A + δA) 𝐱$ is
>$$
>{\| δA 𝐱 \| \over \| A 𝐱 \| } ≤ κ(A) ε
>$$
>if we have the relative pertubation error $\|δA\| = \|A \| ε$.

==**Proof**==
We can assume $A$ is invertible (as otherwise $κ(A) = ∞$). Denote $𝐲 = A 𝐱$ and we have
$$
{\|𝐱 \| \over \| A 𝐱 \|} = {\|A^{-1} 𝐲 \| \over \|𝐲 \|} ≤ \| A^{-1}\|
$$
Thus we have:
$$
{\| δA 𝐱 \| \over \| A 𝐱 \| } ≤ \| δA\| \|A^{-1}\| ≤ κ(A) {\|δA\| \over \|A \|}
$$




Thus for floating point arithmetic we know the error is bounded by $κ(A) {n ϵ_{\rm m} \over 2-nϵ_{\rm m}}$.

If one uses QR to solve $A 𝐱 = 𝐲$ the condition number also gives a meaningful bound on the error. 
As we have already noted, there are some matrices where PLU decompositions introduce large errors, so
in that case well-conditioning is not a guarantee (but it still usually works).

--------------------------------------------------------

## Differential Equations via Finite Differences
>**YouTube Lectures:**
>[Condition Numbers](https://www.youtube.com/watch?v=ih4d0ZRZ60c&feature=youtu.be)
>[Indefinite integration via Finite Differences](https://www.youtube.com/watch?v=Q2tjKg6HLno)
>[Euler Methods](https://www.youtube.com/watch?v=5qoGvoVKr_s)
>[Poisson Equation](https://www.youtube.com/watch?v=txEMyKNhBrk&feature=youtu.be)
>[Convergence of Finite Differences](https://www.youtube.com/watch?v=KKx2Kw6L6JM)

We now see our first application: solving differential equations.
We will focus on the following differential equations:

1. Indefinite integration for $a ≤ x ≤ b$:
$$
\begin{align*}
u(a) = c, u' = f(x)
\end{align*}
$$
2. Linear time-evolution problems for $0 ≤ t ≤ T$:
$$
\begin{align*}
u(0) = c, u' - a(t) u = f(t)
\end{align*}
$$
4. Vector time-evolution problems for $0 ≤ t ≤ T$:
$$
\begin{align*}
𝐮(0) = 𝐜, 𝐮' - A(t) 𝐮 = 𝐟(t)
\end{align*}
$$
4. Nonlinear time-evolution problems for $0 ≤ t ≤ T$:
$$
\begin{align*}
𝐮(0) = 𝐜, 𝐮' = f(t, 𝐮(t))
\end{align*}
$$
5. Poisson equation with Dirichlet conditions for $a ≤ x ≤ b$:
$$
\begin{align*}
u(a) &= c_0, u(b) = c_1, \\
u'' &= f(x)
\end{align*}
$$


Our approach to solving these is to
1. Approximate the solution on $[a,b]$ evaluated on a $n$-point grid
$x_1,…,x_n$ (labelled $t_k$ for time-evolution problems) with _step size_
$$
x_{k+1}-x_k = h = {b-a \over n-1}
$$
for a vector $𝐮 ∈ ℝ^n$
that will be determined by solving a linear system:
$$
\begin{bmatrix}
u(x_1) \\
⋮ \\
u(x_n)
\end{bmatrix} ≈ \underbrace{\begin{bmatrix}
u_1 \\
⋮ \\
u_n
\end{bmatrix}}_𝐮
$$
2. Replace the derivatives with the finite-difference approximations (here $m_k = (x_{k+1} - x_k)/2$ is the mid-point
of the grid):
$$
\begin{align*}
u'(x_k) &≈ {u(x_{k+1}) - u(x_k) \over h} ≈ {u_{k+1} - u_k \over h} \qquad\hbox{(Forward-difference)} \\
u'(m_k) &≈ {u(x_{k+1}) - u(x_k) \over h} ≈ {u_{k+1} - u_k \over h} \qquad\hbox{(Central-difference)} \\
u'(x_k) &≈ {u(x_k) - u(x_{k-1}) \over h} ≈ {u_k - u_{k-1} \over h} \qquad\hbox{(Backward-difference)} \\
u''(x_k) &≈ {u(x_{k+1}) - 2u(x_k) + u_{k-1} \over h^2} ≈ {u_{k+1} - 2u_k + u_{k-1} \over h^2}
\end{align*}
$$
3. Recast the differential equation as a linear system whose solution
is $𝐮$, which we solve using numerical linear algebra.
Add the initial/boundary conditions as extra rows to make sure the
system is square.


**<span style="color:#005757">Remark:</span> (advanced)** One should normally not need to implement these methods oneselves as there
are packages available, e.g. [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl). Moreover Forward and Backward
Euler are only the first baby steps to a wide range of time-steppers, with Runge–Kutta being
one of the most successful.
For example we can solve
a simple differential equation like a pendulum $u'' = -\sin u$ can be solved
as follows (writing at a system $u' = v, v' = -\sin u$):
```julia
using DifferentialEquations, LinearAlgebra, Plots

u = solve(ODEProblem((u,_,x) -> [u[2], -sin(u[1])], [1,0], (0,10)))
plot(u)
```
However, even in these automated packages one has a choice of different methods with
different behaviour, so it is important to understand what is happening.

## 1.  Time-evolution problems

In this section we consider the forward and backward Euler methods, which are based on forward and backward difference
approximations to the derivative. In the problem sheet we will investigate a rule that that takes the average of the two
(with significant benefits). We first discuss the simplest case of indefinite integration, where central differences is also
applicable, then introduce forward and backward
Euler for linear scalar, linear vector, and nonlinear differential equations.


### Indefinite integration

We begin with the simplest differential equation on an interval $[a,b]$:
$$
\begin{align*}
u(a) &= c \\
u'(x) &= f(x)
\end{align*}
$$
Using the forward-difference (which is the standard finite-difference) approximation we 
choose $u_k ≈ u(x_k)$ so that, for $k = 1, …, n-1$:
$$
f(x_k) = u'(x_k) ≈ {u_{k+1} - u_k \over h} = f(x_k)
$$
That is, where $u$ satisfies the differential equation exactly, 
$u_k$ satisfies the _difference equation_ exactly.
We do not include $k = n$ to avoid going outside our grid.

This condition can be recast as a linear system:
$$
\underbrace{{1 \over h} \begin{bmatrix}
-1 & 1\\
& \ddots & \ddots \\
&& -1 & 1
\end{bmatrix}}_{D_h} 𝐮^{\rm f} = \underbrace{\begin{bmatrix} f(x_1) \\ \vdots \\ f(x_{n-1})
\end{bmatrix}}_{𝐟^{\rm f}}
$$
where the super-script ${\rm f}$ denotes that we are using 
forward differences (and is leading towards the
forward Euler method).
Here $D_h ∈ ℝ^{n-1,n}$ so this system is not-invertible. Thus we need to
add an extra row, coming from the initial condition: $𝐞_1^⊤ 𝐮^{\rm f} = c$,
that is:
$$
\begin{bmatrix}
𝐞_1^⊤ \\
D_h
\end{bmatrix} 𝐮^{\rm f} = \underbrace{ \begin{bmatrix}
1 \\
-1/h & 1/h\\
& \ddots & \ddots \\
&& -1/h & 1/h
\end{bmatrix}}_{L_h} 𝐮^{\rm f} = \begin{bmatrix} c \\ 𝐟^{\rm f} \end{bmatrix}
$$
This is a lower-triangular bidiagonal system, so can be solved using
forward substitution in $O(n)$ operations. 

We can also consider discretisation at the mid-point $m_k = {x_{k+1} - x_k \over 2}$,
which is the analogue of using central-differences:
$$
u'(m_k) ≈ {u_{k+1} - u_k \over h} = f(m_k)
$$
That is, we have the exact same system with a different right-hand side:
$$
\underbrace{{1 \over h} \begin{bmatrix}
-1 & 1\\
& \ddots & \ddots \\
&& -1 & 1
\end{bmatrix}}_{D_h} 𝐮^{\rm m} = 
\underbrace{\begin{bmatrix} f(m_1) \\ \vdots \\ f(m_{n-1})
\end{bmatrix}}_{𝐟^{\rm m}}
$$

And of course there is $𝐮^{\rm B}$ coming from the backwards-difference
formula:
$$
u'(x_k) ≈ {u_k - u_{k-1} \over h} = f(x_k)
$$
which we leave as an exercise.


**<span style="color:#008080">Example</span>**

Let's do an example of integrating $\cos x$, and see if our method matches
the true answer of $\sin x$. First we construct the system
as a lower-triangular, `Bidiagonal` matrix:
```julia
using LinearAlgebra, Plots

function indefint(x)
    h = step(x) # x[k+1]-x[k]
    n = length(x)
    L = Bidiagonal([1; fill(1/h, n-1)], fill(-1/h, n-1), :L)
end

n = 10
x = range(0, 1; length=n)
L = indefint(x)
```
We can now solve for our particular problem using both the left and 
mid-point rules:
```julia
c = 0 # u(0) = 0
f = x -> cos(x)


m = (x[1:end-1] + x[2:end])/2 # midpoints


𝐟ᶠ = f.(x[1:end-1]) # evaluate f at all but last points
𝐟ᵐ = f.(m)          # evaluate f at mid-points
𝐮ᶠ = L \ [c; 𝐟ᶠ] # integrate using forward-differences
𝐮ᵐ = L \ [c; 𝐟ᵐ] # integrate using central-differences

plot(x, sin.(x); label="sin(x)", legend=:bottomright)
scatter!(x, 𝐮ᶠ; label="forward")
scatter!(x, 𝐮ᵐ; label="mid")
```
They both are close though the mid-point version is significantly
more accurate.
 We can estimate how fast it converges:
```julia
## Error from indefinite integration with c and f
function forward_err(u, c, f, n)
    x = range(0, 1; length = n)
    uᶠ = indefint(x) \ [c; f.(x[1:end-1])]
    norm(uᶠ - u.(x), Inf)
end

function mid_err(u, c, f, n)
    x = range(0, 1; length = n)
    m = (x[1:end-1] + x[2:end]) / 2 # midpoints
    uᵐ = indefint(x) \ [c; f.(m)]
    norm(uᵐ - u.(x), Inf)
end

ns = 10 .^ (1:8) # solve up to n = 10 million
scatter(ns, forward_err.(sin, 0, f, ns); xscale=:log10, yscale=:log10, label="forward")
scatter!(ns, mid_err.(sin, 0, f, ns); label="mid")
plot!(ns, ns .^ (-1); label="1/n")
plot!(ns, ns .^ (-2); label="1/n^2")
```
This is a log-log plot:we scale both $x$ and $y$ axes logarithmically so that
$n^α$ becomes a straight line where the slope is dictated by $α$.
We seem experimentally that the error for forward-difference is $O(n^{-1})$
while for mid-point/central-differences we get faster $O(n^{-2})$ convergence. 
Both methods appear to be stable.


### Forward Euler

Now consider a scalar linear time-evolution problem for $0 ≤ t ≤ T$:
$$
\begin{align*}
u(0 ) &= c \\
u'(t) - a(t) u(t) &= f(t)
\end{align*}
$$
Label the $n$-point grid as $t_k = (k-1)h$ for $h = T/(n-1)$.

>**Definition (Restriction matrices)**
>Define the $n-1 × n$ _restriction matrices_ as
>$$
>\begin{align*}
>    I_n^{\rm f} := \begin{bmatrix} 1 \\ &⋱ \\ &&1 & 0 \end{bmatrix}\\
>I_n^{\rm b} := \begin{bmatrix} 0 & 1 \\ &&⋱ \\ &&&1  \end{bmatrix} \\
>\end{align*}
>$$


Again we can replace the discretisation using finite-differences, giving us
$$
{u_{k+1} - u_k \over h} - a(t_k) u_k = f(u_k)
$$
for $k = 1,…,n-1$. We need to add the term $a(t_k) u_k$ to our differential equation,
that is. We do this using the $n-1 × n$ _(left) restriction matrix_ that takes a vector
evaluated at $x_1,…,x_n$ and restricts it to $x_1,…,x_{n-1}$,
as well as the $n × n$ _multiplication matrix_
$$
A_n = \begin{bmatrix} a(t_1) \\ &⋱\\&& a(t_n) \end{bmatrix}
$$
Putting everything together we have the system:
$$
\begin{bmatrix}
𝐞_1^⊤ \\
D_h -  I_n^{\rm f}  A_n
\end{bmatrix} 𝐮^{\rm f} = \underbrace{ \begin{bmatrix}
1 \\
-a(t_1)-1/h & 1/h\\
& \ddots & \ddots \\
&& -a(t_{n-1})-1/h & 1/h
\end{bmatrix}}_L 𝐮^{\rm f} = \begin{bmatrix} c \\ I_n^{\rm f} 𝐟 \end{bmatrix}
$$
where $𝐟 = \begin{bmatrix} f(t_1) \\ ⋮ \\ f(t_n) \end{bmatrix}$.

Here is a simple example for solving:
$$
u'(0) = 1, u' + t u = {\rm e}^t
$$
which has an exact solution in terms of a special error function
(which we determined using Mathematica).

```julia
using SpecialFunctions
c = 1
a = t -> t
n = 2000
t = range(0, 1; length=n)
## exact solution, found in Mathematica
u = t -> -(1/2)*exp(-(1+t^2)/2)*(-2sqrt(ℯ) + sqrt(2π)erfi(1/sqrt(2)) - sqrt(2π)erfi((1 + t)/sqrt(2)))

h = step(t)
L = Bidiagonal([1; fill(1/h, n-1)], a.(t[1:end-1]) .- 1/h, :L)

norm(L \ [c; exp.(t[1:end-1])] - u.(t),Inf)
```
We see that it is converging to the true result.


Note that this is a simple forward-substitution of a bidiagonal system,
so we can also just construct it directly:
$$
\begin{align*}
u_1 &= c \\
u_{k+1} &= (1 + h a(t_k)) u_k + h f(t_k)
\end{align*}
$$


**<span style="color:#005757">Remark:</span> (advanced)** Note this can alternatively be reduced to an integral
$$
u(t) = c \hbox{e}^{a t} + \hbox{e}^{a t} \int_0^t f(τ) \hbox{e}^{-a τ} \hbox d τ
$$
and solved as above but this approach is harder to generalise.


### Backward Euler


In Backward Euler we replace the forward-difference with a backward-difference,
that is
$$
{u_k - u_{k-1} \over h} - a(t_k) u_k = f(u_k)
$$
This leads to the system:
$$
\begin{bmatrix}
𝐞_1^⊤ \\
D_h -  I_n^{\rm b}  A_n
\end{bmatrix} 𝐮^{\rm b} = \underbrace{ \begin{bmatrix}
1 \\
-1/h & 1/h -a(t_2)\\
& \ddots & \ddots \\
&& -1/h & 1/h-a(t_n)
\end{bmatrix}}_L 𝐮^{\rm b} = \begin{bmatrix} c \\ I_n^{\rm b} 𝐟 \end{bmatrix}
$$
Again this is a bidiagonal forward-substitution:
$$
\begin{align*}
u_1 &= c \\
(1 - h a(t_{k+1})) u_{k+1} &= u_k + h f(t_{k+1})
\end{align*}
$$
That is,
$$
u_{k+1} = (1 - h a(t_{k+1}))^{-1}(u_k + h f(t_{k+1}))
$$



### Systems of equations

We can also solve systems, that is, equations of the form:
$$
\begin{align*}
𝐮(0) &= 𝐜 \\
𝐮'(t) - A(t) 𝐮(t) &= 𝐟(t)
\end{align*}
$$
where $𝐮, 𝐟 : [0,T] → ℝ^d$ and $A : [0,T] → ℝ^{d × d}$.
We again discretise at the grid $t_k$ by approximating $𝐮(t_k) ≈ 𝐮_k ∈ ℝ^d$.
This can be reduced to a block-bidiagonal system as in the scalar case which is solved via forward-substitution. 
Though it's easier to think of it directly. 

Forward Euler gives us:
$$
\begin{align*}
𝐮_1 &= c \\
𝐮_{k+1} &= 𝐮_k + h A(t_k) 𝐮_k + h 𝐟(t_k)
\end{align*}
$$
That is, each _time-step_ consists of matrix-vector multiplication.
On the other hand Backward Euler requires inverting a matrix
at each time-step:
$$
\begin{align*}
𝐮_1 &= c \\
𝐮_{k+1} &= (I- h A(t_{k+1}))^{-1} (𝐮_k  + h 𝐟(t_{k+1}))
\end{align*}
$$


**<span style="color:#008080">Example</span> (Airy equation)**
Consider the (negative-time) Airy equation:
$$
\begin{align*}
u(0) &= 1 \\
u'(0) &= 0 \\
u''(t) + t u &= 0
\end{align*}
$$
We can recast it as a system by defining
$$
𝐮(x) = \begin{bmatrix} u(x) \\ u'(x) \end{bmatrix}
$$
which satisfies
$$
\begin{align*}
𝐮(0) = \begin{bmatrix} 1 \\ 0 \end{bmatrix} \\
𝐮 - \begin{bmatrix} 0 & 1 \\ -t & 0 \end{bmatrix} 𝐮 = 𝟎.
\end{align*}
$$
It is natural to represent the _time-slices_ $𝐮_k$ as
columns of a matrix $U = [𝐮_1 | ⋯ | 𝐮_n] ∈ ℝ^{2 × n}$. Thus we get:
```julia
n = 100_000
t = range(0, 50; length=n)
A = t -> [0 1; -t 0]
h = step(t)

U = zeros(2, n) # each column is a time-slice
U[:,1] = [1.0,0.0] # initial condition
for k = 1:n-1
    U[:,k+1] = (I + h*A(t[k]))*U[:,k]
end

plot(t, U')
```

We leave implementation of backward Euler as a simple exercise.

**<span style="color:#008080">Example</span> (Heat on a graph)**
Those who took Introduction to Applied Mathematics will recall
heat equation on a graph. Consider a simple graph of $m$ nodes labelled
$1, …, m$ where node $k$ is connected to neighbouring nodes ${k-1}$ and ${k+1}$,
whereas node $1$ is only connected to node $2$ and node $m$ only connected to
${m-1}$. The graph Laplacian corresponding to this system is the matrix:
$$
Δ := \begin{bmatrix} -1 & 1 \\ 
            1 & -2 & ⋱ \\ 
            & 1 & ⋱ & 1 \\
            && ⋱ & -2 & 1 \\
                &&& 1 & -1
                \end{bmatrix}
$$
If we denote the heat at time $t$ at node $k$ as $u_k(t)$,
which we turn into a vector
$$
𝐮(t) = \begin{bmatrix} u_1(t) \\ ⋮ \\ u_m(t) \end{bmatrix}
$$
We consider the case of a periodic forcing at the middle node $n = ⌊m/2⌋$.

Heat equation on this lattice is defined as follows:
$$
𝐮' = Δ𝐮 + 𝐞_{⌊m/2⌋} \cos ωt
$$
We can employ forward and backward Euler:
```julia
n = 1_000 # number of time-steps
t = range(0, 100; length=n)
h = step(t)

m = 50 # number of nodes


Δ = SymTridiagonal([-1; fill(-2.0, m-2); -1], ones(m-1))
ω = 1
f = t -> cos(ω*t) # periodic forcing with period 1

Uᶠ = zeros(m, n) # each column is a time-slice for forward Euler
Uᵇ = zeros(m, n) # each column is a time-slice for backwar Euler

Uᶠ[:,1] = Uᵇ[:,1] = zeros(m) # initial condition



for k = 1:n-1
    Uᶠ[:,k+1] = (I + h*Δ)*Uᶠ[:,k]
    Uᶠ[m÷2,k+1] += h*f(t[k]) # add forcing at 𝐞_1
end

𝐞 = zeros(m); 𝐞[m÷2] = 1;

for k = 1:n-1
    Uᵇ[:,k+1] = (I - h*Δ)\(Uᵇ[:,k] + h*f(t[k+1])𝐞)
end

scatter(Uᶠ[:,end]; label="forward")
scatter!(Uᵇ[:,end]; label="backward")
```
Both match! 

**<span style="color:#005757">Remark:</span>** If you change the number of time-steps to be too small, for example `n = 100`, forward
Euler blows up while backward Euler does not. This will be discussed in the problem
sheet.

**<span style="color:#005757">Remark:</span> (advanced)** Memory allocations are very expensive so in practice one should preallocate and use memory. 

### Nonlinear problems

Forward-Euler extends naturally to nonlinear equations, including the vector case:
$$
𝐮' = f(t, 𝐮(t))
$$
becomes:
$$
𝐮_{k+1} = 𝐮_k + h f(x_k, 𝐮_k)
$$
Here we show a simple solution to a nonlinear Pendulum:
$$
u'' = \sin u
$$
by writing $𝐮 = [u,u']$ we have:


```julia
n = 1000
𝐮 = fill(zeros(2), n)
x = range(0, 20; length=n)
h = step(x) # same as x[k+1]-x[k]

𝐮[1] = [1,0]
for k = 1:n-1
    𝐮[k+1] = 𝐮[k] + h * [𝐮[k][2],-sin(𝐮[k][1])]
end

plot(x, first.(𝐮))
```
As we see it correctly predicts the oscillatory behaviour of a pendulum, and matches the simulation using DifferentialEquations.jl
above.



### 2. Two-point boundary value problems

Here we will only consider one discretisation as it is symmetric:
$$
u''(x_k) ≈ {u_{k-1} - 2u_k + u_{k+1} \over h^2}
$$
That is we use the $n-1 × n+1$ matrix:
$$
D_h^2 := {1 \over h^2} \begin{bmatrix}
1 & -2 & 1 \\ & ⋱ & ⋱ & ⋱ \\
&& 1 & -2 & 1 
\end{bmatrix}
$$


**<span style="color:#008080">Example</span> (Poisson)** Consider the Poisson equation with Dirichlet conditions:
$$
\begin{align*}
u(0) &= c_0 \\
u'' &= f(x) \\
u(1) &= c_1
\end{align*}
$$
which we discretise as
$$
\begin{align*}
u_0 &= c_0 \\
 {u_{k-1} - 2u_k + u_{k+1} \over h^2} &= f(x_k) \\
u_1 &= c_1
\end{align*}
$$
As a linear system this equation becomes:
$$
\begin{bmatrix}
𝐞_1^⊤ \\
D_h^2 \\
𝐞_{n+1}^⊤
\end{bmatrix} 𝐮 = \begin{bmatrix} c_0 \\ f(x_2) \\ ⋮ \\ f(x_{n-1}) \\ c_1 \end{bmatrix}
$$

Thus we solve:
```julia
x = range(0, 1; length = n)
h = step(x)
T = Tridiagonal([fill(1/h^2, n-2); 0], [1; fill(-2/h^2, n-2); 1], [0; fill(1/h^2, n-2)])
u = T \ [1; exp.(x[2:end-1]); 2]
scatter(x, u)
```

We can test convergence on $u(x) = \cos x^2$ which satisfies
$$
\begin{align*}
u(0) = 1 \\
u(1) = \cos 1 \\
u''(x) = -4x^2*cos(x^2) - 2sin(x^2)
\end{align*}
$$
We observe uniform ($∞$-norm) convergence:
```julia
function poisson_err(u, c_0, c_1, f, n)
    x = range(0, 1; length = n)
    h = step(x)
    T = Tridiagonal([fill(1/h^2, n-2); 0], [1; fill(-2/h^2, n-2); 1], [0; fill(1/h^2, n-2)])
    uᶠ = T \ [c_0; f.(x[2:end-1]); c_1]
    norm(uᶠ - u.(x), Inf)
end

u = x -> cos(x^2)
f = x -> -4x^2*cos(x^2) - 2sin(x^2)

ns = 10 .^ (1:8) # solve up to n = 10 million
scatter(ns, poisson_err.(u, 1, cos(1), f, ns); xscale=:log10, yscale=:log10, label="error")
plot!(ns, ns .^ (-2); label="1/n^2")
```



### 3. Convergence

We now study convergence of the approaches for the constant-coefficient case.
We will use _Toeplitz matrices_ as a tool to simplify the explanation.

>**Definition (Toeplitz)** A _Toeplitz matrix_ has constant diagonals: $T[k,j] = a_{k-j}$.


>**Proposition (Bidiagonal Toeplitz inverse)**
>The inverse of a $n × n$ bidiagonal Toeplitz matrix is:
>$$
>\begin{bmatrix}
>1 \\
>-ℓ & 1 \\
>&-ℓ & 1 \\
>&& ⋱ & ⋱ \\
>&&& -ℓ & 1\end{bmatrix} = 
> \begin{bmatrix} 1 \\
>                            ℓ & 1 \\
>                            ℓ^2 & ℓ & 1 \\
>                            ⋮ & ⋱ & ⋱ & ⋱ \\
>                            ℓ^{n-1} & ⋯ & ℓ^2 & ℓ & 1
>\end{bmatrix}              
>$$

>**Theorem (Forward/Backward Euler convergence)**
>Consider the equation
>$$
>u(0) = c, u'(t) + a u(t) = f(t)
>$$
>Denote
>$$
>𝐮 := \begin{bmatrix} u(t_1) \\ ⋮ \\ u(t_n) \end{bmatrix}
>$$
>Assume that $u$ is twice-differentiable with uniformly bounded
>second derivative.
>Then the error for forward/backward Euler is
>$$
>\|𝐮ᶠ - 𝐮\|_∞, \|𝐮ᵇ - 𝐮\|_∞ = O(n^{-1})
>$$

==**Proof**== 
We prove the error bound for forward Euler as backward Euler is similar.
This proof consists of two stages: (1) consistency and (2) stability. 

_Consistency_ means our discretisation approximates the true equation, that is:
$$
\begin{align*}
L𝐮 &= \begin{bmatrix} c \\
        {u(t_2) - u(t_1) \over h} + a u(t_1) \\
        ⋮ \\
        {u(t_n) - u(t_{n-1}) \over h} + a u(t_{n-1}) 
\end{bmatrix} = \begin{bmatrix} c \\
        u'(t_1) + a u(t_1) + u''(τ_1) h \\
        ⋮ \\
        u'(t_{n-1}) + a u(t_{n-1}) + u''(τ_{n-1}) h
\end{bmatrix} \\
\\
&= \begin{bmatrix} c \\
        f(t_1) + u''(τ_1) h \\
        ⋮ \\
        f(t_{n-1}) + u''(τ_{n-1}) h
\end{bmatrix}
= \begin{bmatrix} c \\ 𝐟ᶠ \end{bmatrix} + \begin{bmatrix} 0 \\ δ \end{bmatrix}
\end{align*}
$$
where $t_k ≤ τ_k ≤ t_{k+1}$, and uniform boundedness
implies that $\|δ\|_∞ = O(h)$, or in other words $\|δ\|_1 = O(1)$. 

_Stability_ means the inverse does not blow up the error. We need to be a bit careful and first write, for $ℓ = 1 + h a$,
$$
L = \underbrace{\begin{bmatrix} 1 \\ & h^{-1} \\ && ⋱ \\ &&& h^{-1} \end{bmatrix}}_D
 \underbrace{\begin{bmatrix} 1 \\ 
                        -ℓ & 1 \\ & ⋱ & ⋱ \\
                        && -ℓ &1 \end{bmatrix}}_{L̃}
$$
Stability in this case is the statement that
$$
\|L̃^{-1}\|_{1 → ∞} ≤ (1 +  |a|/n)^{n-1} = O(1)
$$
using the fact (which likely you have seen in first year) that
$$
\lim_{n → ∞}  (1 +  |a|/n)^{n-1} = \exp|a|.
$$


We now combine stability and consistency. We have:
$$
\|𝐮ᶠ - 𝐮\|_∞  = \|L^{-1} (L𝐮ᶠ - L𝐮)\|_∞  = \|L̃^{-1} D^{-1} \begin{bmatrix} 0 \\ δ \end{bmatrix} \|_∞ 
≤ h \|L̃^{-1}\|_{1 → ∞} \|δ\|_1 = O(h).
$$




#### Poisson

For 2D problems we consider Poisson. The first stage is to row-reduce to get a symmetric tridiagonal (pos. def.) matrix:
$$
\begin{bmatrix} 
1 \\
-1/h^2 & 1 \\
    && 1 \\ 
    &&& ⋱ \\
    &&&& 1 & -1/h^2 \\
    &&&&& 1\end{bmatrix} \begin{bmatrix}
    1 \\
    1/h^2 & -2/h^2 & 1/h^2 \\
        & ⋱ & ⋱ & ⋱ \\
        && 1/h^2 & -2/h^2 & 1/h^2 \\
        &&&& 1 \end{bmatrix} \\
$$
$$
= \begin{bmatrix} 
    1 \\
    0 & -2/h^2 & 1/h^2 \\
        & ⋱ & ⋱ & ⋱ \\
        && 1/h^2 & -2/h^2 & 0 \\
        &&&& 1 \end{bmatrix}.
$$

Considering the right-hand side and dropping
the first and last rows our equation becomes:
$$
{1 \over h^2} \underbrace{\begin{bmatrix}
 -2 & 1 \\
        1 & -2 & ⋱ \\
        & ⋱ &  ⋱ & 1 \\
        && 1 & -2  
        \end{bmatrix}}_Δ \begin{bmatrix}
                u_2 \\ ⋮ \\ u_{n-1} \end{bmatrix} = \underbrace{\begin{bmatrix} f(x_2) - c_0/h^2 \\ f(x_3) \\ ⋮ \\ f(x_{n-2}) \\ f(x_{n-1}) - c_1/h^2 \end{bmatrix}}_{𝐟ᵖ}
$$

**<span style="color:#005757">Remark:</span> (advanced)** You may recognise $Δ$ as a discrete Laplacian corresponding to a graph with
Dirichlet conditions, as discussed in first year applied mathematics.
Thus one can interpret finite-differences as approximating a continuous differential equation by
a graph. This view-point extends naturally to higher-dimensional equations. In the problem sheet we also
discuss Neumann series.


>**Theorem (Poisson convergence)** Suppose that $u$ is four-times differentiable with uniformly
>bounded fourth derivative. Then the finite difference approximation to Poisson converges like $O(n^2)$.


==**Proof**==


For consistency we need the Taylor series error of second-order finite differences. We have
$$
\begin{align*}
u(x+h) = u(x) + h u'(x) + h^2 {u''(x) \over 2} + h^3 {u'''(x) \over 6} +  h^4 {u^{(4)}(t_+) \over 24}  \\
u(x-h) = u(x) - h u'(x) + h^2 {u''(x) \over 2} - h^3 {u'''(x) \over 6}  +  h^4 {u^{(4)}(t_-)  \over 24}
\end{align*}
$$
where $t_+ ∈ [x,x+h]$ and $t_- ∈ [x-h,x]$. 
Thus
$$
{u(x+h) - 2u(x) + u(x-h) \over h^2} = u''(x) + h^2 {u^{(4)}(t_+) + u^{(4)}(t_-) \over 24} = u''(x) + O(h^2)
$$
(Note this is a slightly stronger result than used in the solution of PS2.)
Thus we have _consistency_:
$$
{Δ \over h^2} \begin{bmatrix} u_2 \\ ⋮ \\ u_{n-1} \end{bmatrix} = 𝐟ᵖ + {\bf\delta}
$$
where $\|{\bf\delta}\|_∞ = O(h^2)$.


Following PS5 we deduce that it has the Cholesky-like decomposition
$$
Δ = -\underbrace{\begin{bmatrix} 1 & -1 \\  & ⋱ & ⋱ \\ && 1 & -1 \\ &&& 1 \end{bmatrix}}_U \underbrace{\begin{bmatrix} 1 \\ -1 & 1 \\ & ⋱ & ⋱ \\ && -1 & 1 \end{bmatrix} }_{U^⊤}
$$
We can invert:
$$
U^{-1} = \begin{bmatrix} 1 & 1 & ⋯ & 1 \\ & ⋱ & ⋱ & ⋮ \\
                                        && 1 & 1 \\ &&& 1 \end{bmatrix}
$$
Thus we have _stability_: $\|h^2 Δ^{-1}\|_∞ ≤ h^2 \|U^{-1}\|_{∞} \|U^{-⊤}\|_{∞} = 1$.

Putting everything together we have, for $𝐮 = [u(x_1), …, u(x_n)]^⊤$,
$$
\|𝐮ᶠ - 𝐮\|_∞  = \|Δ^{-1} (Δ𝐮ᶠ - Δ𝐮)\|_∞  ≤ \|h^2  Δ^{-1}\|_∞  \| {\bf\delta} \|_∞ = O(n^{-2})
$$



What about the observed instability? The condition number of the matrix provides an intuition
(though not a proof: condition numbers are only upper bounds!).  Here we have
$$
κ_∞(Δ/h^2) = κ_∞(Δ) = \|Δ\|_∞ \|Δ^{-1}\|_∞ ≤ 2 n^2
$$
One can show by looking at $Δ^{-1}$ directly that the condition number is indeed growing like $n^2$.
Thus we _expect_ floating-point errors to magnified propotional to $n^2$ in the linear solve.

---------------------------------------------------------------

## Fourier Series & Transform
>**YouTube Lectures:**
>[Fourier Series](https://www.youtube.com/watch?v=1jCVpILji9g)
>[Trapezium Rule and Fourier Coefficients](https://www.youtube.com/watch?v=gPC_Ychx8SU)
>[Discrete Fourier Transform (DFT)](https://www.youtube.com/watch?v=mva8YMkadVM)
>[Fast Fourier Transform (FFT)](https://www.youtube.com/watch?v=vFliXKbxNBs)

In Part III, Computing with Functions, we work with approximating functions by expansions in
bases: that is, instead of approximating at a grid (as in the Differential Equations chapter),
we approximate functions by other, simpler, functions. The most fundamental basis is (complex) Fourier series:
$$
f(θ) = ∑_{k = -∞}^∞ f̂ₖ {\rm e}^{{\rm i} k θ}
$$
where
$$
f̂ₖ := {1 \over 2π} ∫_0^{2π} f(θ) {\rm e}^{-{\rm i} k θ} {\rm d}θ
$$
In numerical analysis we try to build on the analogy with linear algebra as much as possible.
Therefore we write this as:
$$
f(θ) = \underbrace{[⋯ | {\rm e}^{-2{\rm i}θ} |{\rm e}^{-{\rm i}θ} | \underline 1 | {\rm e}^{{\rm i}θ} | {\rm e}^{2{\rm i}θ} | ⋯]}_{F(θ)}
\underbrace{\begin{bmatrix} ⋮ \\ f̂_{-2} \\ f̂_{-1} \\ \underline{f̂_0} \\ f̂_1 \\ f̂_2 \\ ⋮ \end{bmatrix}}_𝐟̂
$$
Where the underline indicates the zero-index location.

More precisely, we are going to build an approximation using $n$ approximate coefficients $f̂_k^n ≈ f̂_k$.
We separate this into three cases:
1. Odd: If $n = 2m+1$ we approximate
$$
\begin{align*}
f(θ) &≈ ∑_{k = -m}^{m} f̂ₖ^n {\rm e}^{{\rm i} k θ} \\
    &= \underbrace{[ {\rm e}^{-{\rm i}mθ} | ⋯ | {\rm e}^{-2{\rm i}θ} |{\rm e}^{-{\rm i}θ} | 1 | {\rm e}^{{\rm i}θ} | {\rm e}^{2{\rm i}θ} | ⋯ |  {\rm e}^{{\rm i} m θ}]}_{F_{-m:m}(θ)} \begin{bmatrix} f̂_{-m}^n \\ ⋮ \\ f̂_m^n \end{bmatrix}
\end{align*}
$$
2. Even: If $n = 2m$ we approximate
$$
\begin{align*}
f(θ) &≈ ∑_{k = -m}^{m-1} f̂ₖ^n {\rm e}^{{\rm i} k θ} \\
    &= \underbrace{[ {\rm e}^{-{\rm i}mθ} | ⋯ | {\rm e}^{-2{\rm i}θ} |{\rm e}^{-{\rm i}θ} | 1 | {\rm e}^{{\rm i}θ} | {\rm e}^{2{\rm i}θ} | ⋯ |  {\rm e}^{{\rm i} (m-1) θ}]}_{F_{-m:m-1}(θ)} \begin{bmatrix} f̂_{-m}^n \\ ⋮ \\ f̂_{m-1}^n \end{bmatrix}
\end{align*}
$$
3. Taylor: if we know the negative coefficients vanish ($0 = f̂_{-1} = f̂_{-2} = ⋯$) we approximate
$$
\begin{align*}
f(θ) &≈ ∑_{k = 0}^{n-1} f̂ₖ^n {\rm e}^{{\rm i} k θ} \\
    &= \underbrace{[ 1 | {\rm e}^{{\rm i}θ} | {\rm e}^{2{\rm i}θ} | ⋯ |  {\rm e}^{{\rm i} (n-1) θ}]}_{F_{0:n-1}(θ)} \begin{bmatrix} f̂_0^n \\ ⋮ \\ f̂_{n-1}^n \end{bmatrix}
\end{align*}
$$
This can be thought of as an approximate Taylor expansion using the change-of-variables $z = {\rm e}^{{\rm i}θ}$.

### 1. Basics of Fourier series



In analysis one typically works with continuous functions and relates results to continuity. In numerical analysis we inheritely have to work with _vectors_, so it is more natural to  focus on the case where the _Fourier coefficients_ $f̂_k$ are _absolutely convergent_, 
or in otherwords, the $1$-norm of $𝐟̂$ is bounded:
$$
\|𝐟̂\|_1 = ∑_{k=-∞}^∞ |f̂_k| < ∞
$$

We first state a basic results (whose proof is beyond the scope of this module):


>**Theorem (convergence)**
>If the Fourier coeffients are absolutely convergent then
>$$
>f(θ) = ∑_{k = -∞}^∞ f̂ₖ {\rm e}^{{\rm i} k θ},
>$$
>which converges uniformly.

**<span style="color:#005757">Remark:</span> (advanced)** We also have convergence for the continuous version
of the $2$-norm,
$$
\| f \|_2 := \sqrt{\int_0^{2π} |f(θ)|^2 {\rm d} θ},
$$
for any function such that $\| f \|_2 < ∞$, but we won't need that in what follows.


Fortunately, continuity gives us sufficient (though not necessary) conditions for absolute convergence:

>**Proposition (differentiability and absolutely convergence)** If $f : ℝ → ℂ$ and $f'$ are periodic
> and $f''$ is uniformly bounded, then its Fourier coefficients satisfy
>$$
>\|𝐟̂\|₁ < ∞
>$$

==**Proof**==
Integrate by parts twice using the fact that $f(0) = f(2π)$, $f'(0) = f(2π)$:
$$
\begin{align*}
f̂ₖ &= ∫_0^{2π} f(θ) {\rm e}^{-{\rm i} k θ} {\rm d}θ =
[f(θ) {\rm e}^{-{\rm i} k θ}]_0^{2π} + {1 \over {\rm i} k} ∫_0^{2π} f'(θ) {\rm e}^{-{\rm i} k θ} {\rm d}θ \\
&= {1 \over {\rm i} k} [f'(θ) {\rm e}^{-{\rm i} k θ}]_0^{2π} - {1 \over k^2} ∫_0^{2π} f''(θ) {\rm e}^{-{\rm i} k θ} {\rm d}θ \\
&= - {1 \over k^2} ∫_0^{2π} f''(θ) {\rm e}^{-{\rm i} k θ} {\rm d}θ
\end{align*}
$$
thus uniform boundedness of $f''$ guarantees $|f̂ₖ| ≤ M |k|^{-2}$ for some $M$, and we have
$$
∑_{k = -∞}^∞ |f̂ₖ| ≤ |f̂_0|  + 2M ∑_{k = 1}^∞ |k|^{-2}  < ∞.
$$
using the dominant convergence test.



This condition can be weakened to Lipschitz continuity but the proof is  beyond the scope
of this module.
Of more practical importance is the other direction: the more times differentiable a function the
faster the coefficients decay, and thence the faster Fourier series converges.
In fact, if a function is smooth and 2π-periodic its Fourier coefficients decay
faster than algebraically: they decay like $O(k^{-λ})$ for any $λ$. This will be explored in the
problem sheet.

**<span style="color:#005757">Remark:</span> (advanced)** Going further, if we let $z = {\rm e}^{{\rm i} θ}$ then if $f(z)$ is _analytic_ in a
neighbourhood of the unit circle the Fourier coefficients decay _exponentially fast_. And if $f(z)$ is entire
they decay even faster than exponentially.


### 2. Trapezium rule and discrete Fourier coefficients

Let $θ_j = 2πj/n$ for $j = 0,1,…,n$ denote $n+1$ evenly spaced points over $[0,2π]$.
The _Trapezium rule_ over $[0,2π]$ is the approximation:
$$
∫_0^{2π} f(θ) {\rm d}θ ≈ {2 π \over n} \left[{f(0) \over 2} + ∑_{j=1}^{n-1} f(θ_j) + {f(2 π) \over 2} \right]
$$
But if $f$ is periodic we have $f(0) = f(2π)$ we get the _periodic Trapezium rule_:
$$
∫_0^{2π} f(θ) {\rm d}θ ≈ 2 π\underbrace{{1 \over n} ∑_{j=0}^{n-1} f(θ_j)}_{Σ_n[f]}
$$
Define the Trapezium rule approximation to the Fourier coefficients by:
$$
f̂_k^n := Σ_n[f(θ) {\rm e}^{-i k θ}]  = {1 \over n} ∑_{j=0}^{n-1} f(θ_j) {\rm e}^{-i k θ_j}
$$

>**Lemma (Discrete orthogonality)**
>We have:
>$$
>∑_{j=0}^{n-1} {\rm e}^{i k θ_j} = \begin{cases} n & k = \ldots,-2n,-n,0,n,2n,\ldots  \cr
>0 & \hbox{otherwise}
>\end{cases}
>$$
>In other words,
>$$
>Σ_n[{\rm e}^{i (k-j) θ_j}] = \begin{cases} 1 & k-j = \ldots,-2n,-n,0,n,2n,\ldots  \cr
>0 & \hbox{otherwise}
>\end{cases}.
>$$

==**Proof**==

Consider $ω := {\rm e}^{{\rm i} θ_1} = {\rm e}^{2 π {\rm i} \over n}$. This is an $n$ th root of unity: $ω^n = 1$.  Note that ${\rm e}^{{\rm i} θ_j} ={\rm e}^{2 π {\rm i} j \over n}= ω^j$.

(Case 1: $k = pn$ for an integer $p$)
We have
$$
∑_{j=0}^{n-1} {\rm e}^{i k θ_j} = ∑_{j=0}^{n-1} ω^{kj} = ∑_{j=0}^{n-1} ({ω^{pn}})^j =   ∑_{j=0}^{n-1} 1 = n
$$
(Case 2 $k ≠ pn$ for an integer $p$)  Recall that
$$
∑_{j=0}^{n-1} z^j = {z^n-1 \over z-1}.
$$
Then we have
$$
∑_{j=0}^{n-1} {\rm e}^{i k θ_j} = ∑_{j=0}^{n-1} (ω^k)^j = {ω^{kn} -1 \over ω^k -1} = 0.
$$
where we use the fact that $k$ is not a multiple of $n$ to guarantee that $ω^k ≠ 1$.




>**Theorem (discrete Fourier coefficients)**
>If $𝐟̂$ is absolutely convergent then
>$$
>f̂_k^n = ⋯ + f̂_{k-2n} + f̂_{k-n} + f̂_k + f̂_{k+n} + f̂_{k+2n} + ⋯
>$$

==**Proof**==
$$
\begin{align*}
f̂_k^n &= Σ_n[f(θ) {\rm e}^{-i k θ}] = ∑_{j=-∞}^∞ f̂_j Σ_n[f(θ) {\rm e}^{i (j-k) θ}] \\
&= ∑_{j=-∞}^∞ f̂_j \begin{cases} 1 & j-k = \ldots,-2n,-n,0,n,2n,\ldots  \cr
0 & \hbox{otherwise}
\end{cases}
\end{align*}
$$


Note that there is redundancy:

>**Corollary (aliasing)**
>For all $p ∈ ℤ$, $f̂_k^n = f̂_{k+pn}^n$.


In other words if we know $f̂_0^n, …, f̂_{n-1}^n$, we know $f̂_k^n$ for all $k$ via a permutation,
for example if $n = 2m+1$ we have
$$
\begin{bmatrix}
f̂_{-m}^n \\
⋮\\
f̂_m^n
\end{bmatrix} = \underbrace{\begin{bmatrix} &&& 1 \\ &&& ⋱ \\ &&&& 1 \\
    1 \\ & ⋱ \\ && 1 \end{bmatrix}}_{P_σ}
\begin{bmatrix}
f̂_0^n \\
⋮\\
f̂_{n-1}^n
\end{bmatrix}
$$
where $σ$ has Cauchy notation (_Careful_: we are using 1-based indexing here):
$$
\begin{pmatrix}
1 & 2 & ⋯ & m & m+1 & m+2 & ⋯ & n  \\
m+2 & m+3 & ⋯ & n & 1 & 2 & ⋯ & m+1
\end{pmatrix}.
$$



We first discuss the case when all negative coefficients are zero,
noting that the Fourier series is in fact a Taylor series if we let $z = {\rm e}^{{\rm i} θ}$:
$$
f(z) = \sum_{k=0}^∞ f̂_k z^k.
$$
That is, $f̂_0^n, …, f̂_{n-1}^n$ are approximations of the Taylor series coefficients by evaluating
on the boundary.



We can  prove _convergence_ whenever of this
approximation whenever $f$ has absolutely summable coefficients.
We will prove the result here in the special case where the negative
coefficients are zero.


>**Theorem (Taylor series converges)**
>If $0 = f̂_{-1} = f̂_{-2} = ⋯$ and $𝐟̂$ is absolutely convergent then
>$$
>f_n(θ) = ∑_{k=0}^{n-1} f̂_k^n {\rm e}^{{\rm i} k θ}
>$$
>converges uniformly to $f(θ)$.

==**Proof**==

$$
\begin{align*}
|f(θ) - f_n(θ)| &= |∑_{k=0}^{n-1} (f̂_k - f̂_k^n) {\rm e}^{{\rm i} k θ} + ∑_{k=n}^∞ f̂_k {\rm e}^{{\rm i} k θ}| \\
&= |∑_{k=n}^∞ f̂_k ({\rm e}^{{\rm i} k θ} - {\rm e}^{{\rm i} {\rm mod}(k,n) θ})|
≤ 2 ∑_{k=n}^∞ |f̂_k|
\end{align*}
$$
which goes to zero as $n → ∞$.

For the general case we need to choose a range of coefficients that includes roughly an equal number of
negative and positive coefficients (preferring negative over positive in a tie as a convention):
$$
f_n(θ) = ∑_{k=-⌈n/2⌉}^{⌊n/2⌋} f̂ₖ {\rm e}^{{\rm i} k θ}
$$
In the problem sheet we will prove this converges provided the coefficients are absolutely convergent.

### 3. Discrete Fourier transform and interpolation

We note that the map from values to coefficients can be defined as a matrix-vector product using the DFT:


>**Definition (DFT)**
>The _Discrete Fourier Transform (DFT)_ is defined as:
>$$
>\begin{align*}
>Q_n &:= {1 \over √n} \begin{bmatrix} 1 & 1 & 1&  ⋯ & 1 \\
>                                    1 & {\rm e}^{-{\rm i} θ_1} & {\rm e}^{-{\rm i} θ_2} & ⋯ & {\rm e}^{-{\rm i} θ_{n-1}} \\
>                                    1 & {\rm e}^{-{\rm i} 2 θ_1} & {\rm e}^{-{\rm i} 2 θ_2} & ⋯ & {\rm e}^{-{\rm i} 2θ_{n-1}} \\
>                                    ⋮ & ⋮ & ⋮ & ⋱ & ⋮ \\
>                                    1 & {\rm e}^{-{\rm i} (n-1) θ_1} & {\rm e}^{-{\rm i} (n-1) θ_2} & ⋯ & {\rm e}^{-{\rm i} (n-1) θ_{n-1}}
>\end{bmatrix} \\
>&= {1 \over √n} \begin{bmatrix} 1 & 1 & 1&  ⋯ & 1 \\
>                                    1 & ω^{-1} & ω^{-2} & ⋯ & ω^{-(n-1)}\\
>                                    1 & ω^{-2} & ω^{-4} & ⋯ & ω^{-2(n-1)}\\
>                                    ⋮ & ⋮ & ⋮ & ⋱ & ⋮ \\
>                                    1 & ω^{-(n-1)} & ω^{-2(n-1)} & ⋯ & ω^{-(n-1)^2}
>\end{bmatrix}
>\end{align*}
>$$
>for the $n$-th root of unity $ω = {\rm e}^{{\rm i} π/n}$. Note that
>$$
>\begin{align*}
>Q_n^⋆ &= {1 \over √n} \begin{bmatrix}
>1 & 1 & 1&  ⋯ & 1 \\
>1 & {\rm e}^{{\rm i} θ_1} & {\rm e}^{{\rm i} 2 θ_1} & ⋯ & {\rm e}^{{\rm i} (n-1) θ_1} \\
>1 &  {\rm e}^{{\rm i} θ_2}  & {\rm e}^{{\rm i} 2 θ_2} & ⋯ & {\rm e}^{{\rm i} (n-1)θ_2} \\
>⋮ & ⋮ & ⋮ & ⋱ & ⋮ \\
>1 & {\rm e}^{{\rm i} θ_{n-1}} & {\rm e}^{{\rm i} 2 θ_{n-1}} & ⋯ & {\rm e}^{{\rm i} (n-1) θ_{n-1}}
>\end{bmatrix} \\
>&= {1 \over √n} \begin{bmatrix}
>1 & 1 & 1&  ⋯ & 1 \\
>1 & ω^{1} & ω^{2} & ⋯ & ω^{(n-1)}\\
>1 & ω^{2} & ω^{4} & ⋯ & ω^{2(n-1)}\\
>⋮ & ⋮ & ⋮ & ⋱ & ⋮ \\
>1 & ω^{(n-1)} & ω^{2(n-1)} & ⋯ & ω^{(n-1)^2}
>\end{bmatrix}
>\end{align*}
>$$

That is, we have
$$
\underbrace{\begin{bmatrix} f_0^n \\ ⋮ \\ f_{n-1}^n \end{bmatrix}}_{𝐟̂ⁿ} = {1 \over √n} Q_n \underbrace{\begin{bmatrix} f(θ₀) \\ ⋮ \\ f(θₙ) \end{bmatrix}}_{𝐟ⁿ}
$$

The choice of normalisation constant is motivated by the following:

>**Proposition (DFT is Unitary)** $Q_n$ is unitary: $Q_n^⋆ Q_n = Q_n Q_n^⋆ = I$.

==**Proof**==
$$
Q_n Q_n^⋆  = \begin{bmatrix} Σ_n[1] & Σ_n[{\rm e}^{{\rm i} θ}] & ⋯ & Σ_n[{\rm e}^{{\rm i} (n-1) θ}] \\
                            Σ_n[{\rm e}^{-{\rm i} θ}] & Σ_n[1] & ⋯ & Σ_n[{\rm e}^{{\rm i} (n-2) θ}] \\
                            ⋮ & ⋮ & ⋱ & ⋮ \\
                            Σ_n[{\rm e}^{-{\rm i}(n-1) θ}] & Σ_n[{\rm e}^{-{\rm i}(n-2) θ}] & ⋯ & Σ_n[1]
                            \end{bmatrix} = I
$$


In other words, $Q_n$ is easily inverted and we also have a map from discrete Fourier coefficients back to values:
$$
\sqrt{n} Q_n^⋆ 𝐟̂ⁿ = 𝐟ⁿ
$$

>**Corollary (Interpolation)**
>$f_n(θ)$ interpolates $f$ at $θ_j$:
>$$
>f_n(θ_j) = f(θ_j)
>$$

==**Proof**==
We have
$$
f_n(θ_j) = ∑_{k=0}^{n-1} f̂_k^n {\rm e}^{{\rm i} k θ_j} = √n 𝐞_j^⊤ Q_n^⋆ 𝐟̂ⁿ = 𝐞_j^⊤ Q_n^⋆ Q_n 𝐟ⁿ = f(θ_j).
$$




We will leave extending this result to the problem sheet. Note that regardless of choice of coefficients
we interpolate, though some interpolations are better than others:

```julia
using Plots, LinearAlgebra


## evaluates f_n at a point
function finitefourier(𝐟̂ₙ, θ)
    m = n ÷ 2 # use coefficients between -m:m
    ret = 0.0 + 0.0im # coefficients are complex so we need complex arithmetic
    for k = 0:m
        ret += 𝐟̂ₙ[k+1] * exp(im*k*θ)
    end
    for k = -m:-1
        ret += 𝐟̂ₙ[end+k+1] * exp(im*k*θ)
    end
    ret
end

function finitetaylor(𝐟̂ₙ, θ)
    ret = 0.0 + 0.0im # coefficients are complex so we need complex arithmetic
    for k = 0:n-1
        ret += 𝐟̂ₙ[k+1] * exp(im*k*θ)
    end
    ret
end


f = θ -> exp(cos(θ))
n = 7
θ = range(0,2π; length=n+1)[1:end-1] # θ_0, …,θ_{n-1}, dropping θ_n == 2π
Qₙ = 1/sqrt(n) * [exp(-im*(k-1)*θ[j]) for k = 1:n, j=1:n]
𝐟̂ₙ = 1/sqrt(n) * Qₙ * f.(θ)


fₙ = θ -> finitefourier(𝐟̂ₙ, θ)
tₙ = θ -> finitetaylor(𝐟̂ₙ, θ)

g = range(0, 2π; length=1000) # plotting grid
plot(g, f.(g); label="function", legend=:bottomright)
plot!(g, real.(fₙ.(g)); label="Fourier")
plot!(g, real.(tₙ.(g)); label="Taylor")
scatter!(θ, f.(θ); label="samples")
```

We now demonstrate the relationship of Taylor and Fourier coefficients
and their discrete approximations for some examples:

**<span style="color:#008080">Example</span>** Consider the function
$$
f(θ) = {2 \over 2 - {\rm e}^{{\rm i} θ}}
$$
Under the change of variables $z = {\rm e}^{{\rm i} θ}$ we know for
$z$ on the unit circle this becomes (using the geometric series with $z/2$)
$$
{2 \over 2-z} = ∑_{k=0}^∞ {z^k \over 2^k}
$$
i.e., $f̂_k = 1/2^k$ which is absolutely summable:
$$
∑_{k=0}^∞ |f̂_k| = f(0) = 2.
$$
If we use an $n$ point discretisation we get (using the geoemtric series with $2^{-n}$)
$$
f̂_k^n = f̂_k + f̂_{k+n} + f̂_{k+n} + ⋯ = ∑_{p=0}^∞ {1 \over 2^{k+pn}} = {2^{n-k} \over 2^n - 1}
$$
We can verify this numerically:
```julia
f = θ -> 2/(2 - exp(im*θ))
n = 7
θ = range(0,2π; length=n+1)[1:end-1] # θ_0, …,θ_{n-1}, dropping θ_n == 2π
Qₙ = 1/sqrt(n) * [exp(-im*(k-1)*θ[j]) for k = 1:n, j=1:n]

Qₙ/sqrt(n)*f.(θ) ≈ 2 .^ (n .- (0:n-1)) / (2^n-1)
```

### 4. Fast Fourier Transform

Applying $Qₙ$ or its adjoint $Q_n^⋆$ to a vector naively takes $O(n^2)$ operations.
Both can be reduced to $O(n \log n)$ using the celebrated _Fast Fourier Transform_ (FFT),
which is one of the [Top 10 Algorithms of the 20th Century](https://pi.math.cornell.edu/~web6140/)
(You won't believe number 7!).

The key observation is that hidden in $Q_{2n}$ are 2 copies of
$Q_n$. We will work with multiple $n$ we denote the $n$-th root as $ω_n = \exp(2π/n)$.
Note that we can relate a vector of powers of $ω_{2n}$ to two copies of vectors of powers of $ω_n$:
$$
\underbrace{\begin{bmatrix} 1 \\ ω_{2n} \\ ⋮ \\ ω_{2n}^{2n-1} \end{bmatrix}}_{\vec{ω}_{2n}} =
P_σ^⊤ \begin{bmatrix} I_n \\ ω_{2n} I_n \end{bmatrix} \underbrace{\begin{bmatrix} 1 \\ ω_n \\ ⋮ \\ ω_n^{n-1} \end{bmatrix}}_{\vec{ω}_n}
$$
where $σ$ has the Cauchy notation
$$
\begin{pmatrix}
1 & 2 & 3 & ⋯ & n & n+1 & ⋯ & 2n \\
1 & 3 & 5 & ⋯ & 2n-1 & 2 & ⋯ & 2n
\end{pmatrix}
$$
That is, $P_σ$ is the following matrix which takes the even entries
and places them in the first $n$ entries and the odd entries in the
last $n$ entries:
```julia
n = 4
σ = [1:2:2n-1; 2:2:2n]
P_σ = I(2n)[σ,:]
```
and so $P_σ^⊤$ reverses the process.
Thus we have
$$
\begin{align*}
Q_{2n}^⋆ &= {1 \over \sqrt{2n}} \begin{bmatrix} 𝟏_{2n} | \vec{ω}_{2n} | \vec{ω}_{2n}^2 | ⋯ | \vec{ω}_{2n}^{2n-1} \end{bmatrix} \\
&= {1 \over \sqrt{2n}} P_σ^⊤ \begin{bmatrix} 𝟏_{n} &   \vec{ω}_n        & \vec{ω}_n^2          & ⋯ & \vec{ω}_n^{n-1}          & \vec{ω}_n^n  & ⋯ & \vec{ω}_n^{2n-1}  \\
                        𝟏_{n} & ω_{2n} \vec{ω}_n & ω_{2n}^2 \vec{ω}_n^2 & ⋯ & ω_{2n}^{n-1} \vec{ω}_n^{n-1} & ω_{2n}^n \vec{ω}_n^n  & ⋯ & ω_{2n}^{2n-1} \vec{ω}_n^{2n-1}
\end{bmatrix} \\
&= {1 \over \sqrt{2}} P_σ^⊤ \begin{bmatrix} Q_n^⋆ & Q_n^⋆ \\
                                     Q_n^⋆ D_n & -Q_n^⋆ D_n
                                     \end{bmatrix} =
                                     {1 \over \sqrt{2}}P_σ^⊤ \begin{bmatrix} Q_n^⋆ \\ &Q_n^⋆ \end{bmatrix} \begin{bmatrix} I_n & I_n \\ D_n & -D_n \end{bmatrix}
\end{align*}
$$
In other words, we reduced the DFT to two DFTs applied to vectors of half the dimension.

We can see this formula in code:
```julia
function fftmatrix(n)
    θ = range(0,2π; length=n+1)[1:end-1] # θ_0, …,θ_{n-1}, dropping θ_n == 2π
    [exp(-im*(k-1)*θ[j]) for k = 1:n, j=1:n]/sqrt(n)
end

Q₂ₙ = fftmatrix(2n)
Qₙ = fftmatrix(n)
Dₙ = Diagonal([exp(im*k*π/n) for k=0:n-1])
(P_σ'*[Qₙ' Qₙ'; Qₙ'*Dₙ -Qₙ'*Dₙ])[1:n,1:n] ≈ sqrt(2)Q₂ₙ'[1:n,1:n]
```


Now assume $n = 2^q$ so that $\log_2 n = q$. To see that we get $O(n \log n) = O(n q)$ operations we need to count the operations.
Assume that applying $F_n$ takes $≤3n q$ additions and multiplications. The first $n$ rows takes $n$ additions. The last $n$ has $n$ multiplications and $n$ additions.
Thus we have $6nq + 3n ≤ 6n(q+1) = 3 (2n) \log_2(2n)$ additions/multiplications, showing by induction that we have $O(n \log n)$ operations.



**<span style="color:#005757">Remark:</span>** The FFTW.jl package wraps the FFTW (Fastest Fourier Transform in the West) library,
which is a highly optimised implementation
of the FFT that also works well even when $n$ is not a power of 2.
(As an aside, the creator of FFTW [Steven Johnson](https://math.mit.edu/~stevenj/) is now a
Julia contributor and user.)
 Here we approximate $\exp(\cos(θ-0.1))$ using
31 nodes:
```julia
using FFTW
f = θ -> exp(cos(θ-0.1))
n = 31
m = n÷2
## evenly spaced points from 0:2π, dropping last node
θ = range(0, 2π; length=n+1)[1:end-1]

## fft returns discrete Fourier coefficients n*[f̂ⁿ_0, …, f̂ⁿ_(n-1)]
fc = fft(f.(θ))/n

## We reorder using [f̂ⁿ_(-m), …, f̂ⁿ_(-1)] == [f̂ⁿ_(n-m), …, f̂ⁿ_(n-1)]
##  == [f̂ⁿ_(m+1), …, f̂ⁿ_(n-1)]
f̂ = [fc[m+2:end]; fc[1:m+1]]

## equivalent to f̂ⁿ_(-m)*exp(-im*m*θ) + … + f̂ⁿ_(m)*exp(im*m*θ)
fₙ = θ -> transpose([exp(im*k*θ) for k=-m:m]) * f̂

## plotting grid
g = range(0, 2π; length=1000)
plot(abs.(fₙ.(g) - f.(g)))
```
Thus we have successfully approximate the function to roughly machine precision.
The magic of the FFT is because it's $O(n \log n)$ we can scale it to very high orders.
Here we plot the Fourier coefficients for a function that requires around 100k
coefficients to resolve:
```julia
f = θ -> exp(sin(θ))/(1+1e6cos(θ)^2)
n = 100_001
m = n÷2
## evenly spaced points from 0:2π, dropping last node
θ = range(0, 2π; length=n+1)[1:end-1]

## fft returns discrete Fourier coefficients n*[f̂ⁿ_0, …, f̂ⁿ_(n-1)]
fc = fft(f.(θ))/n


## We reorder using [f̂ⁿ_(-m), …, f̂ⁿ_(-1)] == [f̂ⁿ_(n-m), …, f̂ⁿ_(n-1)]
##  == [f̂ⁿ_(m+1), …, f̂ⁿ_(n-1)]
f̂ = [fc[m+2:end]; fc[1:m+1]]

plot(abs.(fc); yscale=:log10, legend=:bottomright, label="default")
plot!(abs.(f̂); yscale=:log10, label="reordered")
```

We can use the FFT to compute some mathematical objects efficiently.
Here is a simple example.

**<span style="color:#008080">Example</span>** Define the following infinite sum (which has no name apparently,
according to Mathematica):
$$
S_n(k) := ∑_{p=0}^∞ {1 \over (k+pn)!}
$$
We can use the FFT to compute $S_n(0), …, S_n(n-1)$ in $O(n \log n)$ operations.
Consider
$$
f(θ) = \exp({\rm e}^{{\rm i} θ}) = ∑_{k=0}^∞ {{\rm e}^{{\rm i} θ} \over k!}
$$
where we know the Fourier coefficients from the Taylor series of ${\rm e}^z$. 
The discrete Fourier coefficients satisfy for $0 ≤ k ≤ n-1$:
$$
f̂_k^n = f̂_k + f̂_{k+n} + f̂_{k+2n} + ⋯ = S_n(k)
$$
Thus we have
$$
\begin{bmatrix}
S_n(0) \\ 
⋮ \\
S_n(n-1)
\end{bmatrix} = {1 \over \sqrt{n}} Q_n \begin{bmatrix} 1 \\
                                \exp({\rm e}^{2{\rm i} π/n}) \\
                                ⋮ \\
                                \exp({\rm e}^{2{\rm i} (n-1) π/n}) \end{bmatrix}
$$
--------------------------------------------------------------

## Orthogonal Polynomials
>**YouTube Lectures:**
>[Orthogonal Polynomials](https://www.youtube.com/watch?v=mTf4688vmaU)
>[Jacobi Matrices](https://www.youtube.com/watch?v=b5UxYx-mULA)
>[Classical Orthogonal Polynomials](https://www.youtube.com/watch?v=fJJcmH5FJ58)

Fourier series proved very powerful for approximating periodic functions.
If periodicity is lost, however, uniform convergence is lost. In this chapter
we introduce alternative bases, _orthogonal polynomials (OPs)_ built on polynomials that are applicable in
the non-periodic setting. That is we consider expansions of the form
$$
f(x) = \sum_{k=0}^∞ c_k p_k(x) ≈ \sum_{k=0}^{n-1} c_k^n p_k(x)
$$
where $p_k(x)$ are special families of polynomials, $c_k$ are expansion coefficients and
$c_k^n$ are approximate coefficients.

Why not use monomials as in Taylor series? Hidden in the previous lecture was that we could effectively
compute Taylor coefficients by evaluating on the unit circle in the complex plane, _only_ if the radius of convergence
was 1. Many functions are smooth on say $[-1,1]$ but have non-convergent Taylor series, e.g.:
$$
{1 \over 25x^2 + 1}
$$
While orthogonal polynomials span the same space as monomials, and therefore we can in theory write an
approximation in monomials, orthogonal polynomials are _much_ more stable.



In addition to numerics, OPs play a very important role in many mathematical areas
including functional analysis, integrable systems, singular integral equations,
complex analysis, and random matrix theory.

1. General properties of OPs: we define orthogonal polynomials, three-term recurrences and Jacobi operators
2. Classical OPs: we define Chebyshev, Legendre, Jacobi, Laguerre, and Hermite.
3. Gaussian quadrature: we see that OPs can be used to construct effective numerical methods for singular integrals
4. Recurrence relationships and Sturm–Liouville equations: we see that classical OPs have many simple recurrences that
are of importance in computation, which also show they are eigenfunctions of simple differential operators.


### 1. General properties of orthogonal polynomials

>**Definition (graded polynomial basis)**
>A set of polynomials $\{p_0(x), p_1(x), … \}$ is _graded_ if $p_n$ is
>precisely degree $n$: i.e.,
>$$
>p_n(x) = k_n x^n + k_n^{(n-1)} x^{n-1} + ⋯ + k_n^{(1)} x + k_n^{(0)}
>$$
>for $k_n ≠ 0$.

Note that if $p_n$ are graded then $\{p_0(x), …, p_n(x) \}$
are a basis of all polynomials of degree $n$.


>**Definition (orthogonal polynomials)**
>Given an (integrable) _weight_ $w(x) > 0$ for $x ∈ (a,b)$,
>which defines a continuous inner product
>$$
>⟨f,g⟩ = ∫_a^b  f(x) g(x) w(x) {\rm d} x
>$$
>a graded polynomial basis $\{p_0(x), p_1(x), … \}$
>are _orthogonal polynomials (OPs)_ if
>$$
>⟨p_n,p_m⟩ = 0
>$$
>whenever $n ≠ m$.


Note in the above
$$
h_n := ⟨p_n,p_n⟩ = \|p_n\|^2 = ∫_a^b  p_n(x)^2 w(x) {\rm d} x > 0.
$$

>**Definition (orthonormal polynomials)**
>A set of orthogonal polynomials $\{q_0(x), q_1(x), … \}$
>are orthonormal if $\|q_n\| = 1$.

>**Definition (monic orthogonal polynomials)**
>A set of orthogonal polynomials $\{q_0(x), q_1(x), … \}$
>are orthonormal if $k_n = 1$.


>**Proposition (expansion)**
>If $r(x)$ is a degree $n$ polynomial, $\{p_n\}$ are orthogonal
>and $\{q_n\}$ are orthonormal then
>$$
>\begin{align*}
>r(x) &= ∑_{k=0}^n {⟨p_k,r⟩ \over \|p_k\|^2} p_k(x) \\
>     &    = ∑_{k=0}^n ⟨q_k,r⟩ q_k(x)
>\end{align*}
>$$

==**Proof**==
Because $\{p_0,…,p_n \}$ are a basis of polynomials we can
write
$$
r(x) = ∑_{k=0}^n r_k p_k(x)
$$
for constants $r_k ∈ ℝ$.
By linearity we have
$$
⟨p_m,r⟩ = ∑_{k=0}^n r_k ⟨p_m,p_k⟩= r_m ⟨p_m,p_m⟩
$$


>**Corollary (zero inner product)**
>If a degree $n$ polynomial $r$ satisfies
>$$
>0 = ⟨p_0,r⟩ = … = ⟨p_n,r⟩
>$$
>then $r = 0$.


OPs are uniquely defined (up to a constant) by the
property that they are orthogonal to all lower degree polynomials.

>**Proposition (orthogonal to lower degree)**
>A polynomial $p$ of precisely degree $n$ satisfies
>$$
>⟨p,r⟩ = 0
>$$
>for all degree $m < n$ polynomials $r$ if and only if
>$p = c q_n$. Therefore an orthogonal polynomial is uniquely
>defined by $k_n$.

==**Proof**==
As $\{p_0,…,p_n\}$ are a basis of all polynomials of degree $n$,
we can write
$$
r(x) = ∑_{k=0}^m a_k p_k(x)
$$
Thus by linearity of inner products we have
$$
⟨cp_n,∑_{k=0}^m a_k p_k⟩ = ∑_{k=0}^m ca_k ⟨p_n, p_k⟩ = 0.
$$

Now for
$$
p(x) = c x^n + O(x^{n-1})
$$
consider $p(x) - c p_n(x)$ which is of degree $n-1$. It satisfies
for $k ≤ n-1$
$$
⟨p_k, p - c p_n⟩ = ⟨p_k, p⟩ - c ⟨p_k, p_n⟩ = 0.
$$
Thus it is zero, i.e., $p(x) = c p_n(x)$.



A consequence of this is that orthonormal polynomials are always a
constant multiple of orthogonal polynomials.


#### 3-term recurrence

The most _fundamental_ property of orthogonal polynomials is their three-term
recurrence.

>**Theorem (3-term recurrence, 2nd form)**
>If $\{p_n\}$ are OPs then there exist real constants
>$a_n, b_n ≠0,c_{n-1} ≠0$
>such that
>$$
>\begin{align*}
>x p_0(x) &= a_0 p_0(x) + b_0 p_1(x)  \\
>x p_n(x) &= c_{n-1} p_{n-1}(x) + a_n p_n(x) + b_n p_{n+1}(x)
>\end{align*}
>$$
>==**Proof**==
>The $n=0$ case is immediate since $\{p_0,p_1\}$ are a basis of degree 1 polynomials.
>The $n >0$ case follows from
>$$
>⟨x p_n, p_k⟩ = ⟨ p_n, xp_k⟩ = 0
>$$
>for $k < n-1$ as $x p_k$ is of degree $k+1 < n$.

Note that
$$
b_n = {⟨p_{n+1}, x p_n⟩ \over \|p_{n+1} \|^2} ≠ 0
$$
since $x p_n = k_n x^{n+1} + O(x^n)$ is precisely degree
$n$. Further,
$$
c_{n-1} = {⟨p_{n-1}, x p_n⟩ \over \|p_{n-1}\|^2 } =
{⟨p_n, x p_{n-1}⟩  \over \|p_{n-1}\|^2 } =  b_{n-1}{\|p_n\|^2  \over \|p_{n-1}\|^2 } ≠ 0.
$$








Clearly if $p_n$ is monic then so is $x p_n$ which leads to the following:

>**Corollary (monic 3-term recurrence)** If
>$\{p_n\}$ are monic then $b_n =  1$.


**<span style="color:#008080">Example</span>** What are the  monic OPs $p_0(x),…,p_3(x)$ with respect to $w(x) = 1$ on $[0,1]$?
We can construct these using Gram–Schmidt, but exploiting the 3-term recurrence to reduce the computational cost.
We have $p_0(x) = q_0(x) = 1$, which we see is orthogonal:
$$
\|p_0\|^2 = ⟨p_0,p_0⟩ = ∫_0^1 d x = 1.
$$
We know from the 3-term recurrence that
$$
x p_0(x) = a_0 p_0(x) +  p_1(x)
$$
where
$$
a_0 = {⟨p_0,x p_0⟩  \over \|p_0\|^2} = ∫_0^1 x {\rm d} x = 1/2.
$$
Thus
$$
\begin{align*}
p_1(x) = x p_0(x) - a_0 p_0(x) = x-1/2 \\
\|p_1\|^2 = ∫_0^1 (x^2 - x + 1/4) {\rm d} x = 1/12
\end{align*}
$$
From
$$
x p_1(x) = c_0 p_0(x) + a_1 p_1(x) +  p_2(x)
$$
we have
$$
\begin{align*}
c_0 &= {⟨p_0,x p_1⟩  \over \|p_0\|^2} = ∫_0^1 (x^2 - x/2) {\rm d} x = 1/12 \\
a_1 &= {⟨p_1,x p_1⟩  \over \|p_1\|^2} = 12 ∫_0^1 (x^3 - x^2 + x/4) {\rm d} x = 1/2 \\
p_2(x) &= x p_1(x) - c_0 - a_1 p_1(x) = x^2 - x + 1/6 \\
\|p_2\|^2 &= \int_0^1 (x^4 - 2x^3 + 4x^2/3 - x/3 + 1/36) {\rm d} x = {1 \over 180}
\end{align*}
$$
Finally, from
$$
x p_2(x) = c_1 p_1(x) + a_2 p_2(x) +  p_3(x)
$$
we have
$$
\begin{align*}
c_1 &= {⟨p_1,x p_2⟩  \over \|p_1\|^2} = 12 ∫_0^1 (x^4 - 3x^3/2 +2x^2/3 -x/12)  {\rm d} x = 1/15 \\
a_2 &= {⟨p_2,x p_2⟩  \over \|p_2\|^2} = 180 ∫_0^1 (x^5 - 2x^4 +4x^3/3 - x^2/3 + x/36) {\rm d} x = 1/2 \\
p_3(x) &= x p_2(x) - c_1 p_1(x)- a_2 p_2(x) = x^3 - x^2 + x/6 - x/15 + 1/30 -x^2/2 + x/2 - 1/12 \\
&= x^3 - 3x^2/2 + 3x/5 -1/20
\end{align*}
$$


#### Jacobi matrix


The three-term recurrence can also be interpreted as a matrix known
as the Jacobi matrix:

>**Corollary (Jacobi matrix)**
>For
>$$
>P(x) := [p_0(x) | p_1(x) | ⋯]
>$$
>then we have
>$$
>x P(x) = P(x) \underbrace{\begin{bmatrix} a_0 & c_0 \\
>                                                        b_0 & a_1 & c_1\\
>                                                        & b_1 & a_2 & ⋱ \\
>                                                        && ⋱ & ⋱
>                                                        \end{bmatrix}}_X
>$$
>More generally, for any polynomial $a(x)$ we have
>$$
>a(x) P(x) = P(x) a(X).
>$$

For the special cases of orthonormal and monic polynomials we have extra structure:

>**Corollary (orthonormal 3-term recurrence)** If
>$\{q_n\}$ are orthonormal then its recurrence coefficients satisfy $c_n = b_n$.
>That is, the Jacobi matrix is symmetric:
>$$
>X = \begin{bmatrix} a_0 & b_0 \\
>                                                        b_0 & a_1 & b_1\\
>                                                        & b_1 & a_2 & ⋱ \\
>                                                        && ⋱ & ⋱
>                                                        \end{bmatrix}
>$$

==**Proof**==
$$
b_n = ⟨x q_n, q_{n+1}⟩ = ⟨q_n, x q_{n+1}⟩ = c_{n-1}.
$$




**Remark** Typically the Jacobi matrix is the transpose $J := X^⊤$.
If the basis are orthonormal then $X$ is symmetric and they are the same.

**Remark (advanced)** If you are worried about multiplication of infinite matrices/vectors
note it is well-defined by the standard definition because it is banded.
It can also be defined in terms of functional analysis where one considers these
as linear operators (functions of functions) between vector spaces.

**Remark (advanced)** Every integrable weight generates a family of
orthonormal polynomials, which in turn generates a symmetric Jacobi matrix.
>There is a "Spectral Theorem for Jacobi matrices" that says one can go the
>other way: every tridiagonal symmetric matrix with bounded entries is a Jacobi
>matrix for some integrable weight with compact support. This is an example of what
>[Barry Simon](https://en.wikipedia.org/wiki/Barry_Simon) calls a ''Gem of spectral theory'',
>that is.


**<span style="color:#008080">Example</span> (uniform weight Jacobi matrix)** Consider the
monic orthogonal polynomials $p_0(x),p_1(x),…,p_3(x)$ for $w(x) = 1$ on $[0,1]$ constructed above.
We can write the 3-term recurrence coefficients we have computed above as the Jacobi matrix:
$$
x [p_0(x)| p_1(x)| ⋯] = [p_0(x)| p_1(x)| ⋯] \underbrace{\begin{bmatrix} 1/2 & 1/12 \\
                                                            1 & 1/2 & 1/15 \\
                                                            & 1 & 1/2 & ⋱ \\
                                                            & & ⋱ & ⋱ \end{bmatrix}}_X
$$
We can compute the orthonormal polynomials, using
$$
\|p_3\|^2 = \int_0^1 (x^6 - 3x^5 + 69x^4/20 -19x^3/10 + 51x^2/100 - 3x/50 + 1/400) {\rm d}x = {1 \over 2800}
$$
as:
$$
\begin{align*}
q_0(x) &= p_0(x) \\
q_1(x) &= \sqrt{12} p_1(x)= \sqrt{3} (2  x - 1) \\
q_2(x) &= \sqrt{180} p_2(x) = \sqrt{5} (6x^2 - 6x + 1) \\
q_3(x) &= \sqrt{2800} p_3(x) = \sqrt{7} (20x^3-30x^2 + 12x - 1)
\end{align*}
$$
which have the Jacobi matrix
$$
\begin{align*}
x [q_0(x)| q_1(x)| ⋯] &= x [p_0(x)| p_1(x)| ⋯] \underbrace{\begin{bmatrix} 1 \\ & 2\sqrt{3} \\ && 6 \sqrt{5} \\ &&& 20 \sqrt{7} \\
&&&& ⋱
\end{bmatrix}}_D \\
&= [q_0(x)| q_1(x)| ⋯] D^{-1} X D \\
\\
&= \begin{bmatrix} 1/2 & 1/\sqrt{12} \\
                    1/\sqrt{12} & 1/2 &  1/\sqrt{15} \\
                    & 1/\sqrt{15} & 1/2 & ⋱ \\
                    & ⋱ & ⋱ \end{bmatrix}
\end{align*}
$$
which is indeed symmetric. The problem sheet explores a more elegant way of doing this.


**<span style="color:#008080">Example</span> (expansion)** Consider expanding a low degree polynomial like $f(x) = x^2$ in $p_n(x)$. We have
$$
⟨p_0, f⟩ = ∫_0^1 x^2 {\rm d} x = 1/3
⟨p_1, f⟩ = ∫_0^1 x^2 (x - 1/2) {\rm d} x = 1/12
⟨p_2, f⟩ = ∫_0^1 x^2 (x^2 - x + 1/6) {\rm d} x \\
= 1/180
$$
Thus we have:
$$
f(x) = {p_0(x) \over 3} + p_1(x) + p_2(x) = [p_0(x) | p_1(x) | p_2(x) | ⋯] \begin{bmatrix} 1/3 \\ 1 \\ 1 \\ 0 \\ ⋮ \end{bmatrix}
$$
We multiply (using that $b_2 = 1$ for monic OPs) to deduce:
$$
\begin{align*}
x f(x) &= x[p_0(x) | p_1(x) | p_2(x) | ⋯] \begin{bmatrix} 1/3 \\ 1 \\ 1 \\ 0 \\ ⋮ \end{bmatrix} \\
\\
&= [p_0(x) | p_1(x) | p_2(x) | ⋯] X \begin{bmatrix} 1/3 \\ 1 \\ 1 \\ 0 \\ ⋮ \end{bmatrix} \\
\\
&= [p_0(x) | p_1(x) | p_2(x) | ⋯]  \begin{bmatrix} 1/4 \\ 9/10 \\ 3/2 \\ 1 \\ 0 \\ ⋮ \end{bmatrix} \\
\\
&= {p_0(x) \over 4} + {9 p_1(x) \over 10} + {3 p_2(x) \over 2} + p_3(x)
\end{align*}
$$




### 2. Classical orthogonal polynomials

Classical orthogonal polynomials are special families of orthogonal polynomials with a number
of beautiful properties, for example
1. Their derivatives are also OPs
2. They are eigenfunctions of simple differential operators

As stated above orthogonal polynomials are uniquely defined by the weight
$w(x)$ and the constant $k_n$. We consider:

1. **Chebyshev** polynomials (1st kind) $T_n(x)$: $w(x) = 1/\sqrt{1-x^2}$ on $[-1,1]$.
2.  **Chebyshev** polynomials (2nd kind) $U_n(x)$: $\sqrt{1-x^2}$ on $[-1,1]$.
2. **Legendre** polynomials $P_n(x)$: $w(x) = 1$ on $[-1,1]$.
3. **Hermite** polynomials $H_n(x): w(x) = \exp(-x^2)$  on $(-\infty,\infty)$.

Other important families discussed are

1. **Ultrapsherical** polynomials
2. **Jacobi** polynomials
3. **Laguerre** polynomials


#### Chebyshev

>**Definition (Chebyshev polynomials, 1st kind)** $T_n(x)$ are orthogonal with respect to $1/\sqrt{1-x^2}$
>and satisfy:
>$$
>T_0(x) = 1, T_n(x) = 2^{n-1} x^n + O(x^{n-1})
>$$


>**Definition (Chebyshev polynomials, 2nd kind)** $T_n(x)$ are orthogonal with respect to $1/\sqrt{1-x^2}$.
>$$
>U_n(x) = 2^n x^n + O(x^{n-1})
>$$


>**Theorem (Chebyshev T are cos)**
>$$
>T_n(x) = \cos(n\cos^{-1}(x))
>$$
>In other words
>$$
>T_n(cos(θ)) = \cos (n θ).
>$$


==**Proof**==

We need to show that $p_n(x) := \cos(n\cos^{-1}(x))$ are
1. graded polynomials
2. orthogonal w.r.t. $1/\sqrt{1-x^2}$ on $[-1,1]$, and
3. have the right normalisation constant $k_n = 2^{n-1}$ for $n = 2,…$.

Property (2) follows under a change of variables:
$$
\int_{-1}^1 {p_n(x) p_m(x) \over \sqrt{1-x^2}} {\rm d} x =
\int_{-π}^π {cos(nθ) cos(mθ) \over \sqrt{1-cos^2 θ}} \sin θ {\rm d} θ =
\int_{-π}^π cos(nθ) cos(mθ) {\rm d} x = 0
$$
if $n ≠ m$.

To see that they are graded we use the fact that
$$
x p_n(x) = \cos θ \cos n θ = {\cos(n-1)θ + cos(n+1)θ \over 2} = {p_{n-1}(x) + p_{n+1}(x) \over 2}
$$
In other words $p_{n+1}(x) = 2x p_n(x) - p_{n-1}(x)$.
Since each time we multiply by $2x$ and $p_0(x) = 1$ we have
$$
p_n(x) = (2x)^n + O(x^{n-1})
$$
which completes the proof.



Buried in the proof is the 3-term recurrence:

>**Corollary**
>$$
>\begin{align*}
>x T_0(x) = T_1(x) \\
>x T_n(x) = {T_{n-1}(x) + T_{n+1}(x) \over 2}
>\end{align*}
>$$

In the problem sheet you will show the following:

>**Theorem (Chebyshev U are sin)**
>For $x = \cos θ$,
>$$
>U_n(x) = {\sin(n+1) θ \over \sin θ}
>$$
>which satisfy:
>$$
>\begin{align*}
>x U_0(x) &= U_1(x)/2 \\
>x U_n(x) &= {U_{n-1}(x) \over 2} + {U_{n+1}(x) \over 2}.
>\end{align*}
>$$

#### Legendre

>**Definition (Pochhammer symbol)** The Pochhammer symbol is
>$$
>\begin{align*}
>(a)_0 &= 1 \\
>(a)_n &= a (a+1) (a+2) ⋯ (a+n-1).
>\end{align*}
>$$

>**Definition (Legendre)** Legendre polynomials
>$P_n(x)$ are orthogonal polynomials with respect to $w(x) = 1$ on $[-1,1]$, with
>$$
>k_n = {2^n (1/2)_n \over n!}
>$$

The reason for this complicated normalisation constant is both historical and
that it leads to simpler formulae for recurrence relationships.


Classical orthogonal polynomials have _Rodriguez formulae_, defining orthogonal
polynomials as high order derivatives of simple functions. In this case we have:

>**Theorem (Legendre Rodriguez)**
>$$
>P_n(x) = {1 \over (-2)^n n!}{{\rm d}^n \over {\rm d} x^n} (1-x^2)^n
>$$

==**Proof**==
We need to verify:
1. graded polynomials
2. orthogonal to all lower degree polynomials on $[-1,1]$, and
3. have the right normalisation constant $k_n = {2^n (1/2)_n \over n!}$.

(1) follows since its a degree $n$ polynomial (the $n$-th derivative of a degree $2n$ polynomial).
(2) follows by integration by parts. Note that $(1-x^2)^n$ and its first $n-1$ derivatives vanish at $\pm 1$.
If $r_m$ is a degree $m < n$ polynomial we have:
$$
\begin{align*}
∫_{-1}^1 {{\rm d}^n \over {\rm d} ^n} (1-x^2)^n r_m(x) {\rm d}x
&= -∫_{-1}^1 {{\rm d}^{n-1} \over {\rm d} x^{n-1}} (1-x^2)^n r_m'(x) {\rm d}x \\
&= ⋯ = (-1)^n ∫_{-1}^1 (1-x^2) r_m^{(n)}(x) {\rm d}x = 0.
\end{align*}
$$
(3) follows since:
$$
\begin{align*}
{{\rm d}^n \over {\rm d} x^n}[(-1)^n x^{2n} + O(x^{2n-1})]
&= (-1)^n 2n {{\rm d}^{n-1} \over {\rm d} x^{n-1}} x^{2n-1}+ O(x^{2n-1})] \\
&= (-1)^n 2n (2n-1) {{\rm d}^{n-2} \over {\rm d} x^{n-2}} x^{2n-2}+ O(x^{2n-2})] \\
&= ⋯ = (-1)^n 2n (2n-1) ⋯ (n+1) x^n + O(x^{n-1})
\end{align*}
$$
which satisfies:
$$
(1/2)(1/2+1) ⋯ (n-1/2) = {1 \over 2^n} (1+2) ⋯ (2n-1)
$$



>**Theorem (Legendre 3-term recurrence)**

TBA




### 3. Gaussian quadrature

Consider integration
$$
\int_a^b f(x) w(x) {\rm d}x.
$$
For periodic integration we approximated (using the Trapezium rule) an integral by a sum.
We can think of it as a weighted sum:
$$
{1 \over 2π} \int_0^{2π} f(θ) {\rm d} θ ≈  ∑_{j=0}^{n-1} w_j f(θ_j)
$$
where $w_j = 1/n$. Replacing an integral by a weighted sum is a known as a _quadrature_ rule.
This quadrature rule had several important properties:
1. It was _exact_ for integrating trigonometric polynomials with 2n-1 coefficients
$$
p(θ) = \sum_{k=1-n}^{n-1} p̂_k \exp({\rm i}k θ)
$$
as seen by the formula
$$
∑_{j=0}^{n-1} w_j f(θ_j) = p̂_0^n = … + p̂_{n-1} + p̂_0 + p̂_n + ⋯ = p̂_0 = {1 \over 2π} \int_0^{2π} p(θ) {\rm d} θ
$$
2. It exactly recovered the coefficients ($p̂_k^n = p̂_k$) for expansions of trigonometric polynomials with $n$ coeffiicents:
$$
p(θ) = \sum_{k=-⌈(n-1)/2⌉}^{⌊(n-1)/2⌋} p̂_k \exp({\rm i}k θ)
$$
3. It converged fast for smooth, periodic functions $f$.

In this section we consider other quadrature rules
$$
\int_a^b f(x) w(x) {\rm d}x ≈ \sum_{j=1}^n w_j f(x_j)
$$
We want to choose $w_j$ and $x_j$ so that the following properties are satisfied:
1. It is _exact_ for integrating polynomials up to degree $2n-1$:
$$
p(θ) = \sum_{k=0}^{2n-1} c_k q_k(x)
$$
2. It exactly recovers the coefficients for expansions:
$$
p(θ) = \sum_{k=0}^{n-1} c_k q_k(x)
$$
3. It converges fast for smooth functions $f$.
We will focus on properties (1) and (2) as property (3) is more involved.

The key to property (1) is to use _roots (zeros) of $q_n(x)$_.

>**Lemma** $q_n(x)$ has exactly $n$ distinct roots.

==**Proof**==

Suppose $x_1, …,x_j$ are the roots where $q_n(x)$ changes sign, that is,
$$
q_n(x) = c_j (x-x_j) + O((x-x_j)^2)
$$
for $c_j ≠ 0$. Then
$$
q_n(x) (x-x_1) ⋯(x-x_j)
$$
does not change sign.
In other words:
$$
⟨q_n,(x-x_1) ⋯(x-x_j) ⟩ = \int_a^b q_n(x) (x-x_1) ⋯(x-x_j) {\rm d} x ≠ 0.
$$
This is only possible if $j = n$.





>**Lemma (zeros)** The zeros $x_1, …,x_n$ of $q_n(x)$ are the eigenvalues of the truncated Jacobi matrix
>$$
>X_n := \begin{bmatrix} a_0 & b_0 \\
>                         b_0 & ⋱ & ⋱ \\
>                         & ⋱ & a_{n-2} & b_{n-2} \\
>                         && b_{n-2} & a_{n-1} \end{bmatrix} ∈ ℝ^{n × n}.
>$$
>More precisely,
>$$
>X_n Q_n = Q_n \begin{bmatrix} x_1 \\ & ⋱ \\ && x_n \end{bmatrix}
>$$
>for the orthogonal matrix
>$$
>Q_n = \begin{bmatrix}
>p_0(x_1) & ⋯ & p_0(x_n) \\
>⋮  & ⋯ & ⋮  \\
>p_{n-1}(x_1) & ⋯ & p_{n-1}(x_n)
>\end{bmatrix}
>$$

==**Proof**==

We construct the eigenvector (noting $b_{n-1} p_n(x_j) = 0$):
$$
X_n \begin{bmatrix} p_0(x_j) \\ ⋮ \\ p_{n-1}(x_j) \end{bmatrix} =
\begin{bmatrix} a_0 p_0(x_j) + b_0 p_1(x_j) \\
 b_0 p_0(x_j) + a_1 p_1(x_j) + b_1 p_2(x_j) \\
⋮ \\
b_{n-3} p_{n-3}(x_j) + a_{n-2} p_{n-2}(x_j) + b_{n-2} p_{n-1}(x_j) \\
b_{n-2} p_{n-2}(x_j) + a_{n-1} p_{n-1}(x_j) + b_{n-1} p_n(x_j)
\end{bmatrix} = x_j \begin{bmatrix} p_0(x_j) \\
 p_1(x_j) \\
⋮ \\
p_n(x_j)
\end{bmatrix}
$$


## Interpolation and Gaussian quadrature
>**YouTube Lectures:**
>[Polynomial Interpolation](https://www.youtube.com/watch?v=VZuKlqtCtY4)
>[Orthogonal Polynomial Roots](https://www.youtube.com/watch?v=c9zRON-ZJPA)
>[Interpolatory Quadrature Rules](https://www.youtube.com/watch?v=5HEzowo-0OY&feature=youtu.be)
>[Gaussian Quadrature](https://www.youtube.com/watch?v=DOpssd4gztc)


_Polynomial interpolation_ is the process of finding a polynomial that equals data at a precise set of points.
_Quadrature_ is the act of approximating an integral by a weighted sum:
$$
\int_a^b f(x) w(x) {\rm d}x ≈ \sum_{j=1}^n w_j f(x_j).
$$
In these notes we see that the two concepts are intrinsically linked:  interpolation leads naturally
to quadrature rules. Moreover, by using a set of points $x_j$ linked to orthogonal polynomials we get
significantly more accurate rules, and in fact can use quadrature to compute expansions in orthogonal polynomials that
interpolate. That is, we can mirror the link between the Trapezium rule, Fourier series, and interpolation but
now for polynomials.


1. Polynomial Interpolation: we describe how to interpolate a function by a polynomial.
3. Truncated Jacobi matrices: we see that truncated Jacobi matrices are diagonalisable
in terms of orthogonal polynomials and their zeros. 
2. Interpolatory quadrature rule: polynomial interpolation leads naturally to ways to integrate
functions, but onely realisable in the simplest cases.
3. Gaussian quadrature: Using roots of orthogonal polynomials and truncated Jacobi matrices 
leads naturally to an efficiently
computable interpolatory quadrature rule. The _miracle_ is its exact for twice as many polynomials as
expected.



### 1. Polynomial Interpolation

We already saw a special case of polynomial interpolation, where we saw that the polynomial
$$
f(z) ≈ ∑_{k=0}^{n-1} f̂_k^n z^k
$$
equaled $f$ at evenly spaced points on the unit circle: ${\rm e}^{{\rm i} 2π j/n}$. 
But here we consider the following:

>**Definition (interpolatory polynomial)** Given $n$ distinct points $x_1,…,x_n ∈ ℝ$ 
>and $n$ _samples_ $f_1,…,f_n ∈ ℝ$, a degree $n-1$
>_interpolatory polynomial_ $p(x)$ satisfies
>$$
>p(x_j) = f_j
>$$

The easiest way to solve this problem is to invert the Vandermonde system:

>**Definition (Vandermonde)** The _Vandermonde matrix_ associated with $n$ distinct points $x_1,…,x_n ∈ ℝ$
>is the matrix
>$$
>V := \begin{bmatrix} 1 & x_1 & ⋯ & x_1^{n-1} \\
>                    ⋮ & ⋮ & ⋱ & ⋮ \\
>                    1 & x_n & ⋯ & x_n^{n-1}
>                    \end{bmatrix}
>$$

>**Proposition (interpolatory polynomial uniqueness)** 
>The interpolatory polynomial is unique, and the Vandermonde matrix is invertible.

**==Proof==**
Suppose $p$ and $p̃$ are both interpolatory polynomials. Then $p(x) - p̃(x)$ vanishes at $n$ distinct points $x_j$. By the fundamental theorem of
algebra it must be zero, i.e., $p = p̃$.

For the second part, if $V 𝐜 = 0$ for $𝐜 ∈ ℝ$ then for $q(x) = c_1 + ⋯ + c_n x^{n-1}$ we have
$$
q(x_j) = 𝐞_j^⊤ V 𝐜 = 0
$$
hence $q$ vanishes at $n$ distinct points and is therefore 0, i.e., $𝐜 = 0$.

∎

Thus a quick-and-dirty way to to do interpolation is to invert the Vandermonde matrix
(which we saw in the least squares setting with more samples then coefficients):
```julia
using Plots, LinearAlgebra
f = x -> cos(10x)
n = 5

x = range(0, 1; length=n)# evenly spaced points (BAD for interpolation)
V = x .^ (0:n-1)' # Vandermonde matrix
c = V \ f.(x) # coefficients of interpolatory polynomial
p = x -> dot(c, x .^ (0:n-1))

g = range(0,1; length=1000) # plotting grid
plot(g, f.(g); label="function")
plot!(g, p.(g); label="interpolation")
scatter!(x, f.(x); label="samples")
```

But it turns out we can also construct the interpolatory polynomial directly.
We will use the following with equal $1$ at one grid point
and are zero at the others:

>**Definition (Lagrange basis polynomial)** The _Lagrange basis polynomial_ is defined as
>$$
>ℓ_k(x) := ∏_{j ≠ k} {x-x_j \over x_k - x_j} =  {(x-x_1) ⋯(x-x_{k-1})(x-x_{k+1}) ⋯ (x-x_n) \over (x_k - x_1) ⋯ (x_k - x_{k-1}) (x_k - x_{k+1}) ⋯ (x_k - x_n)}
>$$

Plugging in the grid points verifies the following:

>**Proposition (delta interpolation)**
>$$
>ℓ_k(x_j) = δ_{kj}
>$$

We can use these to construct the interpolatory polynomial:

>**Theorem (Lagrange interpolation)**
>The unique  polynomial of degree at most $n-1$ that interpolates $f$ at $x_j$ is:
>$$
>p(x) = f(x_1) ℓ_1(x) + ⋯ + f(x_n) ℓ_n(x)
>$$

**==Proof==**
Note that
$$
p(x_j) = ∑_{j=1}^n f(x_j) ℓ_k(x_j) = f(x_j)
$$
so we just need to show it is unique. Suppose $p̃(x)$ is a  polynomial
of degree at most $n-1$
that also interpolates $f$.


∎

**<span style="color:#008080">Example</span>** We can interpolate $\exp(x)$ at the points $0,1,2$:
$$
\begin{align*}
p(x) &= ℓ_1(x) + {\rm e} ℓ_2(x) + {\rm e}^2 ℓ_3(x) = 
{(x - 1) (x-2) \over (-1)(-2)} + {\rm e} {x (x-2) \over (-1)} + 
{\rm e}^2 {x (x-1) \over 2} \\
&= (1/2 - {\rm e} +{\rm e}^2/2)x^2
+  (-3/2 + 2 {\rm e}  - {\rm e}^2 /2)  x + 1
\end{align*}
$$


**Remark** Interpolating at evenly spaced points is a really **bad** idea:
interpolation is inheritely ill-conditioned. 
The problem sheet asks you to explore
this experimentally.

### 2. Roots of orthogonal polynomials and truncated Jacobi matrices

We now consider roots (zeros) of orthogonal polynomials $q_n(x)$. This is important as we shall
see they are useful for interpolation and quadrature. For interpolation to be well-defined we
first need to guarantee that the roots are distinct.

>**Lemma** $q_n(x)$ has exactly $n$ distinct roots.

**==Proof==**

Suppose $x_1, …,x_j$ are the roots where $q_n(x)$ changes sign, that is,
$$
q_n(x) = c_j (x-x_j) + O((x-x_j)^2)
$$
for $c_j ≠ 0$. Then
$$
q_n(x) (x-x_1) ⋯(x-x_j)
$$
does not change sign.
In other words:
$$
⟨q_n,(x-x_1) ⋯(x-x_j) ⟩ = \int_a^b q_n(x) (x-x_1) ⋯(x-x_j) w(x) {\rm d} x ≠ 0.
$$
This is only possible if $j = n$ as $q_n(x)$ is orthogonal w.r.t. all lower degree
polynomials.

∎

>**Definition (truncated Jacobi matrix)** Given a symmetric Jacobi matrix $X$,
>(or the weight $w(x)$ whose orthonormal polynomials are associated with $X$)
> the _truncated Jacobi matrix_ is
>$$
>X_n := \begin{bmatrix} a_0 & b_0 \\
>                         b_0 & ⋱ & ⋱ \\
>                         & ⋱ & a_{n-2} & b_{n-2} \\
>                         && b_{n-2} & a_{n-1} \end{bmatrix} ∈ ℝ^{n × n}
>$$



>**Lemma (zeros)** The zeros $x_1, …,x_n$ of $q_n(x)$ are the eigenvalues of the truncated Jacobi matrix $X_n$.
>More precisely,
>$$
>X_n Q_n = Q_n \begin{bmatrix} x_1 \\ & ⋱ \\ && x_n \end{bmatrix}
>$$
>for the orthogonal matrix
>$$
>Q_n = \begin{bmatrix}
>q_0(x_1) & ⋯ & q_0(x_n) \\
>⋮  & ⋯ & ⋮  \\
>q_{n-1}(x_1) & ⋯ & q_{n-1}(x_n)
>\end{bmatrix} \begin{bmatrix} α_1^{-1} \\ & ⋱ \\ && α_n^{-1} \end{bmatrix}
>$$
>where $α_j = \sqrt{q_0(x_j)^2 + ⋯ + q_{n-1}(x_j)^2}$.

**==Proof==**

We construct the eigenvector (noting $b_{n-1} q_n(x_j) = 0$):
$$
X_n \begin{bmatrix} q_0(x_j) \\ ⋮ \\ q_{n-1}(x_j) \end{bmatrix} =
\begin{bmatrix} a_0 q_0(x_j) + b_0 q_1(x_j) \\
 b_0 q_0(x_j) + a_1 q_1(x_j) + b_1 q_2(x_j) \\
⋮ \\
b_{n-3} q_{n-3}(x_j) + a_{n-2} q_{n-2}(x_j) + b_{n-2} q_{n-1}(x_j) \\
b_{n-2} q_{n-2}(x_j) + a_{n-1} q_{n-1}(x_j) + b_{n-1} q_n(x_j)
\end{bmatrix} = x_j \begin{bmatrix} q_0(x_j) \\
 q_1(x_j) \\
⋮ \\
q_{n-1}(x_j)
\end{bmatrix}
$$
The result follows from normalising the eigenvectors. Since $X_n$ is symmetric
the eigenvector matrix is orthogonal.

∎

**<span style="color:#008080">Example</span> (Chebyshev roots)** Consider $T_n(x) = \cos n {\rm acos}\, x$. The roots 
are $x_j = \cos θ_j$ where $θ_j = (j-1/2)π/n$ for $j = 1,…,n$ are the roots of $\cos n θ$
that are inside $[0,π]$. 

Consider the $n = 3$ case where we have
$$
x_1,x_2,x_3 = \cos(π/6),\cos(π/2),\cos(5π/6) = \sqrt{3}/2,0,-\sqrt{3/2}
$$
We also have from the 3-term recurrence:
$$
\begin{align*}
T_0(x) = 1 \\
T_1(x) = x \\
T_2(x) = 2x T_1(x) - T_0(x) = 2x^2-1 \\
T_3(x) = 2x T_2(x) - T_1(x) = 4x^2-3x
\end{align*}
$$
We orthonormalise by rescaling
$$
\begin{align*}
q_0(x) &= 1/\sqrt{π} \\
q_k(x) &= T_k(x) \sqrt{2}/\sqrt{π}
\end{align*}
$$
so that the Jacobi matrix is symmetric:
$$
x [q_0(x)|q_1(x)|⋯] = [q_0(x)|q_1(x)|⋯] \underbrace{\begin{bmatrix} 0 & 1/\sqrt{2} \\
                            1/\sqrt{2} & 0 & 1/2 \\
                            &1/2 & 0 & 1/2 \\
                             &   & 1/2 & 0 & ⋱ \\
                              &  && ⋱ & ⋱
\end{bmatrix}}_X
$$
We can then confirm that we have constructed an eigenvector/eigenvalue of the $3 × 3$ truncation of the Jacobi matrix,
e.g. at $x_2 = 0$:
$$
\begin{bmatrix} 
0 & 1/\sqrt{2} \\
1/\sqrt{2} & 0 & 1/2 \\
    & 1/2 & 0\end{bmatrix} \begin{bmatrix} q_0(0) \\ q_1(0) \\ q_2(0) 
    \end{bmatrix} = {1 \over \sqrt π} \begin{bmatrix} 
0 & 1/\sqrt{2} \\
1/\sqrt{2} & 0 & 1/2 \\
    & 1/2 & 0\end{bmatrix} \begin{bmatrix} 1 \\ 0 \\ -{1 \over \sqrt{2}}
    \end{bmatrix} =\begin{bmatrix} 0 \\ 0 \\ 0
    \end{bmatrix}
$$



### 3. Interpolatory quadrature rules

>**Definition (interpolatory quadrature rule)** Given a set of points $𝐱 = [x_1,…,x_n]$
>the interpolatory quadrature rule is:
>$$
>Σ_n^{w,𝐱}[f] := ∑_{j=1}^n w_j f(x_j)
>$$
>where
>$$
>w_j := ∫_a^b ℓ_j(x) w(x) {\rm d} x
>$$


>**Proposition (interpolatory quadrature is exact for polynomials)** 
>Interpolatory quadrature is exact for all degree $n-1$ polynomials $p$:
>$$
>∫_a^b p(x) w(x) {\rm d}x = Σ_n^{w,𝐱}[f]
>$$

**==Proof==**
The result follows since, by uniqueness of interpolatory polynomial:
$$
p(x) = ∑_{j=1}^n p(x_j) ℓ_j(x)
$$

∎

**<span style="color:#008080">Example</span>  (arbitrary points)** Find the interpolatory quadrature rule for $w(x) = 1$ on $[0,1]$ with  points $[x_1,x_2,x_3] = [0,1/4,1]$?
We have:
$$
\begin{align*}
w_1 = \int_0^1 w(x) ℓ_1(x) {\rm d}x  = \int_0^1 {(x-1/4)(x-1) \over (-1/4)(-1)}{\rm d}x = -1/6 \\
w_2 = \int_0^1 w(x) ℓ_2(x) {\rm d}x  = \int_0^1 {x(x-1) \over (1/4)(-1)}{\rm d}x = 8/9 \\
w_3 = \int_0^1 w(x) ℓ_3(x) {\rm d}x  = \int_0^1 {x(x-1/4) \over 1/4}{\rm d}x = 5/18
\end{align*}
$$
That is we have
$$
Σ_n^{w,𝐱}[f]  = -{f(0) \over 6} + {8f(1/4) \over 9} + {5 f(1) \over 18}
$$
This is indeed exact for polynomials up to degree $2$ (and no more):
$$
Σ_n^{w,𝐱}[1] = 1, Σ_n^{w,𝐱}[x] = 1/2, Σ_n^{w,𝐱}[x^2] = 1/3, Σ_n^{w,𝐱}[x^2] = 7/24 ≠ 1/4.
$$

**<span style="color:#008080">Example</span>   (Chebyshev roots)** Find the interpolatory quadrature rule for $w(x) = 1/\sqrt{1-x^2}$ on $[-1,1]$ with points equal to the
roots of $T_3(x)$. This is a special case of Gaussian quadrature which we will approach in another way below. We use:
$$
\int_{-1}^1 w(x) {\rm d}x = π, \int_{-1}^1 xw(x) {\rm d}x = 0, \int_{-1}^1 x^2 w(x) {\rm d}x = {π/2}
$$
Recall from before that $x_1,x_2,x_3 = \sqrt{3}/2,0,-\sqrt{3}/2$. Thus we have:
$$
\begin{align*}
w_1 = \int_{-1}^1 w(x) ℓ_1(x) {\rm d}x = \int_{-1}^1 {x(x+\sqrt{3}/2) \over (\sqrt{3}/2) \sqrt{3} \sqrt{1-x^2}}{\rm d}x = {π \over 3} \\
w_2 = \int_{-1}^1 w(x) ℓ_2(x) {\rm d}x = \int_{-1}^1 {(x-\sqrt{3}/2)(x+\sqrt{3}/2) \over (-3/4)\sqrt{1-x^2}}{\rm d}x = {π \over 3} \\
w_3 = \int_{-1}^1 w(x) ℓ_3(x) {\rm d}x = \int_{-1}^1 {(x-\sqrt{3}/2) x \over (-\sqrt{3})(-\sqrt{3}/2) \sqrt{1-x^2}}{\rm d}x = {π \over 3}
\end{align*}
$$
(It's not a coincidence that they are all the same but this will differ for roots of other OPs.) 
That is we have
$$
Σ_n^{w,𝐱}[f]  = {π \over 3}(f(\sqrt{3}/2) + f(0) + f(-\sqrt{3}/2)
$$
This is indeed exact for polynomials up to degree $n-1=2$, but it goes all the way up to $2n-1 = 5$:
$$
\begin{align*}
Σ_n^{w,𝐱}[1] &= π, Σ_n^{w,𝐱}[x] = 0, Σ_n^{w,𝐱}[x^2] = {π \over 2}, \\
Σ_n^{w,𝐱}[x^3] &= 0, Σ_n^{w,𝐱}[x^4] &= {3 π \over 8}, Σ_n^{w,𝐱}[x^5] = 0 \\
Σ_n^{w,𝐱}[x^6] &= {9 π \over 32} ≠ {5 π \over 16}
\end{align*}
$$
We shall explain this miracle next.





### 4. Gaussian quadrature

Gaussian quadrature is the interpolatory quadrature rule corresponding
to the grid $x_j$ defined as the roots of the orthogonal polynomial $q_n(x)$.
We shall see that it is exact for polynomials up to degree $2n-1$, i.e., double
the degree of other interpolatory quadrature rules from other grids.



>**Definition (Gauss quadrature)** Given a weight $w(x)$, the Gauss quadrature rule is:
>$$
>∫_a^b f(x)w(x) {\rm d}x ≈ \underbrace{∑_{j=1}^n w_j f(x_j)}_{Σ_n^w[f]}
>$$
>where $x_1,…,x_n$ are the roots of $q_n(x)$ and 
>$$
>w_j := {1 \over α_j^2} = {1 \over q_0(x_j)^2 + ⋯ + q_{n-1}(x_j)^2}.
>$$
>Equivalentally, $x_1,…,x_n$ are the eigenvalues of $X_n$ and
>$$
>w_j = ∫_a^b w(x) {\rm d}x Q_n[1,j]^2.
>$$
>(Note we have $∫_a^b w(x) {\rm d} x q_0(x)^2 = 1$.)

In analogy to how Fourier series are orthogonal with respect to Trapezium rule,
Orthogonal polynomials are orthogonal with respect to Gaussian quadrature:

>**Lemma (Discrete orthogonality)**
>For $0 ≤ ℓ,m ≤ n-1$,
>$$
>Σ_n^w[q_ℓ q_m] = δ_{ℓm}
>$$

**==Proof==**
$$
Σ_n^w[q_ℓ q_m] = ∑_{j=1}^n {q_ℓ(x_j) q_m(x_j) \over α_j^2}
= \left[q_ℓ(x_1)/ α_1 | ⋯ | {q_ℓ(x_n)/ α_n}\right] 
\begin{bmatrix}
q_m(x_1)/α_1 \\
⋮ \\
q_m(x_n)/α_n \end{bmatrix} = 𝐞_ℓ Q_n Q_n^⊤ 𝐞_m = δ_{ℓm}
$$

∎

Just as approximating Fourier coefficients using Trapezium rule gives a way of
interpolating at the grid, so does Gaussian quadrature:

>**Theorem (interpolation via quadrature)**
>$$
>f_n(x) = ∑_{k=0}^{n-1} c_k^n q_k(x)\hbox{ for } c_k^n := Σ_n^w[f q_k]
>$$
>interpolates $f(x)$ at the Gaussian quadrature points $x_1,…,x_n$.

**==Proof==**

Consider the Vandermonde-like matrix:
$$
Ṽ := \begin{bmatrix} q_0(x_1) & ⋯ & q_{n-1}(x_1) \\
                ⋮ & ⋱ & ⋮ \\
                q_0(x_n) & ⋯ & q_{n-1}(x_n) \end{bmatrix}
$$
and define
$$
Q_n^w := Ṽ^⊤ \begin{bmatrix} w_1 \\ &⋱ \\&& w_n \end{bmatrix} = \begin{bmatrix} q_0(x_1)w_1 & ⋯ &  q_0(x_n) w_n \\
                ⋮ & ⋱ & ⋮ \\
                w_1q_{n-1}(x_1) & ⋯ & q_{n-1}(x_n)w_n \end{bmatrix}
$$
so that
$$
\begin{bmatrix}
c_0^n \\
⋮ \\
c_{n-1}^n \end{bmatrix} = Q_n^w \begin{bmatrix} f(x_1) \\ ⋮ \\ f(x_n) \end{bmatrix}.
$$
Note that if $p(x) = [q_0(x) | ⋯ | q_{n-1}(x)] 𝐜$ then
$$
\begin{bmatrix}
p(x_1) \\
⋮ \\
p(x_n)
\end{bmatrix} = Ṽ 𝐜
$$
But we see that (similar to the Fourier case)
$$
Q_n^w Ṽ = \begin{bmatrix} Σ_n^w[q_0 q_0] & ⋯ & Σ_n^w[q_0 q_{n-1}]\\
                ⋮ & ⋱ & ⋮ \\
                Σ_n^w[q_{n-1} q_0] & ⋯ & Σ_n^w[q_{n-1} q_{n-1}]
                \end{bmatrix} = I_n
$$

∎

>**Corollary** Gaussian quadrature is an interpolatory quadrature rule
>with the interpolation points equal to the roots of $q_n$:
>$$
>Σ_n^w[f] = Σ_n^{w,𝐱}[f]
>$$

**==Proof==**
We want to show its the same as integrating the interpolatory polynomial:
$$
\int_a^b f_n(x) w(x) {\rm d}x = {1 \over q_0(x)} \sum_{k=0}^{n-1} c_k^n \int_a^b q_k(x) q_0(x) w(x) {\rm d}x
= {c_0^n \over q_0} = Σ_n^w[f].
$$
∎



A consequence of being an interpolatory quadrature rule is that it is exact for all
polynomials of degree $n-1$. The _miracle_ of Gaussian quadrature is it is exact for twice
as many!



>**Theorem (Exactness of Gauss quadrature)** If $p(x)$ is a degree $2n-1$ polynomial then
>Gauss quadrature is exact:
>$$
>∫_a^b p(x)w(x) {\rm d}x = Σ_n^w[p].
>$$

**==Proof==**
Using polynomial division algorithm (e.g. by matching terms) we can write
$$
p(x) = q_n(x) s(x) + r(x)
$$
where $s$ and $r$ are degree $n-1$. Then we have:
$$
\begin{align*}
Σ_n^w[p] &= \underbrace{Σ_n^w[q_n s]}_{\hbox{$0$ since evaluating $q_n$ at zeros}} + Σ_n^w[r] = ∫_a^b r(x) w(x) {\rm d}x
= \underbrace{∫_a^b q_n(x)s(x) w(x) {\rm d}x}_{\hbox{$0$ since $s$ is degree $<n$}}  + ∫_a^b r(x) w(x) {\rm d}x \\
&= ∫_a^b p(x)w(x) {\rm d}x.
\end{align*}
$$
∎


**<span style="color:#008080">Example</span> (Chebyshev expansions)** 
Consider the construction of Gaussian quadrature for $n = 3$. To determine the weights we need:
$$
w_j^{-1} = α_j^2 = q_0(x_j)^2 + q_1(x_j)^2 + q_2(x_j)^2 = 
{1 \over π} + {2 \over π} x_j^2 + {2 \over π} (2x_j^2-1)^2
$$
We can check each case and deduce that $w_j = π/3$.
Thus we recover the interpolatory quadrature rule.
Further, we can construct the transform
$$
\begin{align*}
Q_3^w &= \begin{bmatrix}
w_1 q_0(x_1) & w_2 q_0(x_2) & w_3 q_0(x_3) \\
w_1 q_1(x_1) & w_2 q_1(x_2) & w_3 q_1(x_3) \\
w_1 q_3(x_1) & w_2 q_3(x_2) & w_3 q_3(x_3) 
\end{bmatrix}\\
&= {π \over 3} \begin{bmatrix} 1/\sqrt{π} & 1/\sqrt{π} & 1/\sqrt{π} \\
                                x_1\sqrt{2/π} & x_2\sqrt{2/π} & x_3\sqrt{2/π} \\
                                (2x_1^2-1)\sqrt{2/π} &(2x_2^2-1)\sqrt{2/π} & (2x_3^2-1)\sqrt{2/π}
                                \end{bmatrix} \\
                                &= 
                                {\sqrt{π} \over 3} \begin{bmatrix} 1 & 1 & 1 \\
                                \sqrt{6}/2 & 0 & -\sqrt{6}/2 \\
                                1/\sqrt{2} &-\sqrt{2} & 1/\sqrt{2}
                                \end{bmatrix}
\end{align*}
$$
We can use this to expand a polynomial, e.g. $x^2$:
$$
Q_3^2 \begin{bmatrix}
x_1^2 \\
x_2^2 \\
x_3^2 
\end{bmatrix} = {\sqrt{π} \over 3} 
\begin{bmatrix} 1 & 1 & 1 \\
\sqrt{6}/2 & 0 & -\sqrt{6}/2 \\
1/\sqrt{2} &-\sqrt{2} & 1/\sqrt{2}
\end{bmatrix} 
\begin{bmatrix} 3/4 \\ 0 \\ 3/4 \end{bmatrix} =
\begin{bmatrix}
{\sqrt{π} / 2} \\
0 \\
{\sqrt{π} / (2\sqrt{2})}
\end{bmatrix}
$$
In other words:
$$
x^2 = {\sqrt π \over 2} q_0(x) + {\sqrt π \over 2\sqrt 2} q_2(x) = {1 \over 2} T_0(x) + {1 \over 2} T_2(x)
$$
which can be easily confirmed.

