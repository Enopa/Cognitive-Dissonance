using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{

    [SerializeField] private float Speed;
    Rigidbody2D Rig2D;
    Vector2 Mover;

    void Start()
    {
        Rig2D = GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        Vector2 Move = new Vector2(Input.GetAxisRaw("Horizontal"), Input.GetAxisRaw("Vertical")).normalized;
        Mover = Move * Speed * Time.deltaTime;
        Rig2D.MovePosition(Rig2D.position + Mover); 
    }
}
