import std.stdio;
import std.math;
import std.conv;

/// Main driver test program
void main()
{
    float[] array = [.78, .17, .39, .26, .72, .94, .21, .12, .23, .68, 0.99, 0.11, 0.28, 0.44, 0.83, 0.56, 0.29]; 

    auto sortedArray = bucketSort(array);

    writefln("Unsorted %s\n Sorted %s", array, sortedArray);

}

LinkedList!float[] bucketSort(float[] A)
{
    LinkedList!float[] B;
    B.length = A.length;
    int n = cast(int)A.length;
    foreach(i; 0..n)
    {
        B[i] = new LinkedList!float;
    }
    foreach(i; 1..n + 1)
    {
        B[cast(ulong)floor(n * A[i -1])].insert(A[i - 1]);
    }

    foreach(i; 0..n)
        B[i].sort();

    return B;
}

/// Simple linked list with only insert, sort, and toArray operations
/// This is all that is need for this example.
class LinkedList(T)
{
    void insert(T element)
    {
        if(head is null)
        {
            head = new node!T;
            head.data = element;
            return;
        }

        node!T* current = head;
        while(current.next !is null)
        {
            current = current.next;
        }
        current.next = new node!T;
        current.next.data = element;
    }

    void sort()
    {
        if(head is null)
            return;

        node!T* current = head;
        while(current.next !is null)
        {
            if(current.next.data < current.data)
            {
                T temp = current.data;
                current.data = current.next.data;
                current.next.data = temp;
            }
            current = current.next;
        }
    }

    T[] toArray()
    {
        T[] t;
        if(head is null)
        {
            return t;
        }

        node!T* current = head;
        t ~= current.data;
        while(current.next !is null)
        {
            t ~= current.next.data;
            current = current.next;
        }

        return t;
    }

    override string toString() {return to!string(this.toArray());}

private:
    node!T* head;

    struct node(T)
    {
        T data;
        node!T* next;
    }
}