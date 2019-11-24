## MakeCacheMatrix function creates a list for a new matrix
## CacheSolve solves the matrix and calculates its inverse that is saved in Cache

## This function creates the list with  4 functions
makeCacheMatrix <- function(x = matrix()) {
    inverse <- NULL
    set <- function(y) {
        x <<- y
        inverse <<- NULL
    }
    get <- function() x
    setInverse <- function(Newinverse) inverse <<- Newinverse
    getInverse <- function() inverse
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}

## This functional solves the matrix and stores the results in the Cache
cacheSolve <- function(x, ...) {
    inverse <- x$getInverse()
    if (is.null(inverse)) {
        data <- x$get()
        inverse <- x$setInverse(solve(data))
    }
    return(inverse)
    ## Return a matrix that is the inverse of 'x'
}
