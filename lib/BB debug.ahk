Persistent
b := BB()
b.a()

;bb.showV()

class BB
{
    static v := 6

    a()
    {
        this.showV()
    }

   showV()
    {
        Tooltip(this.v)
    }
}
