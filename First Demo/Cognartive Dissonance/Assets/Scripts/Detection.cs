using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Detection : MonoBehaviour
{
    public bool Detected;
    public LayerMask WhatIsPlayer;
    public float DetectionRange;
    public Collider2D ObjectsInArea;
    public Vector2 Offset;
    void Start()
    {
        
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        //Checks for the specified layer
        Detected = Physics2D.OverlapCircle(transform.position + (Vector3) Offset, DetectionRange, WhatIsPlayer);
        ObjectsInArea = Physics2D.OverlapCircle(transform.position + (Vector3) Offset, DetectionRange, WhatIsPlayer);
    }

    private void OnDrawGizmosSelected()
    {
        //Draws the gizmo for visibility
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position + (Vector3) Offset, DetectionRange);
    }
}
