using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{
    public GameObject Proj;
    public float Radius;
    public float Rate;
    float NextRate;


    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.time >= NextRate)
        {
            Vector2 Pos = GenNewPos(Random.Range(-Radius, Radius), Radius);
            Instantiate(Proj, Pos, Quaternion.identity);
            NextRate = Time.time + 1f / Rate;
        }
    }

    public Vector2 GenNewPos(float x, float r)
    {
        //pick if it should be positive or negative
        int Rand = Random.Range(-1, 2);
        int o = 0;
        if (Rand <= 0) o = -1;
        if (Rand >= 1) o = 1;

        float y = (Mathf.Sqrt((r * r) - (x * x))) * o;
        Vector2 Pos = new Vector2(x, y);
        return Pos;
    }

    private void OnDrawGizmos()
    {
        Gizmos.DrawWireSphere(transform.position, Radius);
    }

}
