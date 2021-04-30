using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CombatMovement : MonoBehaviour
{
    [SerializeField]
    private int Speed;
    private Rigidbody2D body;
    private float rotation = 0;

    // Start is called before the first frame update
    void Start()
    {
        body = GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void Update()
    {
        rotation += (Input.GetAxisRaw("Horizontal") * Speed) * -1;
        body.MoveRotation(rotation);
    }
}
