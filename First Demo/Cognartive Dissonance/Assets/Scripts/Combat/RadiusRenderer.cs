using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RadiusRenderer : MonoBehaviour
{
    [SerializeField]
    private int numberOfSpheres = 0;


    private Color[] colors = { Color.yellow, Color.black, Color.green, Color.red, Color.magenta };

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        

    }

    private void OnDrawGizmosSelected()
    {
        

        int colorIndex = 0;
        for (int i = 0; i < numberOfSpheres; i++)
        {
            Gizmos.color = colors[colorIndex];
            colorIndex++;
            if (colorIndex >= colors.Length)
            {
                colorIndex = 0;
            }
            Gizmos.DrawWireSphere(transform.position, 7 + i);
        }
    }
}
