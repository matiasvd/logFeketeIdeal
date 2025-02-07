import sympy as sp

# ######
# Matrix $W$ from matrix $X$: $X=W W^T$
# 
# I. Given $X \in \mathbb{R}^{n \times n}$ of rank $r$, real, symmetric and positive-semidefinite:
# 
# 1. find (reduced) eigen-decomposition of $X$: $X=QDQ^T$; $D \in \mathbb{R}^{r \times r}$ diagonal with non null eigenvalues, $Q \in \mathbb{R}^{n \times r}$ with orthonormal basis of eigenvectors as columns.
# 2. take $W=Q \sqrt{D} \in \mathbb{R}^{n \times r}$.
# 
# Row $i$ of $W$ represents the coordinates of a point $w_i$ on the sphere $S^{r-1} \subset \mathbb{R}^r$.
# 
# The basis of eigenvectors is orthonormalized using the $QR$ factorization.
#
# Argument d is the dimension of the ambient space: $S^{d-1} \subset \mathbb{R}^d$. It must be $r \leq d$.
# 
# 12/2024 - MVD.
# 
# ######
def WfromX(X, d, verb=False):
    X = sp.simplify(X)

    print('\nConstructing W from X...')

    #########
    ## Diagonalization of X
    ## https://stackoverflow.com/questions/46361388/computation-of-symbolic-eigenvalues-with-sympy
    ## https://docs.sympy.org/latest/tutorials/intro-tutorial/matrices.html
    #########
    P, D = X.diagonalize()
    
    if verb == True :
        print('\nEigenvalues of X')
        sp.pprint(D)
        
        print('\nEigenvectors of X')
        sp.pprint(P)

    (n, n) = sp.shape(X) # size of matrix    
    # print('\n')
    # print( sp.latex(D) )
    # print('\n')
    # print( sp.latex(P) )
    
    #########
    ## Orthonormalized diagonalization for non null eigenvalues
    ## Applies QR factorization to orthonormalize.
    #########
    rkX = X.rank()
        
    D2 = D[(n-rkX):, (n-rkX):] # non-null eigenvalues

    if verb == True :
        print('\nNon-null eigenvalues D2:')
        sp.pprint(D2)
    
    #########
    # Corresponding orthogonal matrix of eigenvectors Q
    #########
    P2 = P[:, (n-rkX):] # eigenvectors associated to non-null eigenvalues
    Q, R = P2.QRdecomposition() # orthonormalize columns of P2
    
    Q = sp.simplify(Q)

    if verb == True :
        print('\nCorresponding orthogonal matrix of eigenvectors Q:')
        sp.pprint(Q)
    
    # print('\n')
    # print( sp.latex(Q) )

    if verb == True :
        print('\nColumns of Q are orthonormal?:', sp.simplify(Q.T * Q) == sp.eye(rkX) )
    
        # verifies
        print('\nX == Q * D2 * Q.T?:', X == sp.simplify(Q * D2 * Q.T) )
    
    ########
    ## Coordinates of points on the sphere
    ########
    W = sp.simplify( Q * sp.sqrt(D2) )
    
    if rkX < d : # less rank than the dimension of the desired ambient space
        W = W.hstack(W, sp.zeros(n, d-rkX) ) # adds matrix of zeros to the right of W

    # print('\n')
    # print( sp.latex(W) )
    
    print('\nMatrix W of coordinates on the sphere:')
    sp.pprint(W)
    
    print('\nX == W * W.T?:', X == sp.simplify(W * W.T) )

    return W
