using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{

    [SerializeField] private float Speed;
    Rigidbody2D Rig2D;
    Vector2 Mover;
    [SerializeField]
    private float checkDistance;

    void Start()
    {
        Rig2D = GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        //Basic Movement
        Vector2 Move = new Vector2(Input.GetAxisRaw("Horizontal"), Input.GetAxisRaw("Vertical")).normalized;
        Mover = Move * Speed * Time.deltaTime;
        Rig2D.MovePosition(Rig2D.position + Mover);
        //Making sure player faces direction of travel (idk if you have an easier script for this???)
        Vector2 lookPoint = new Vector2(transform.position.x, transform.position.y) + Move;
        transform.right = (new Vector3(lookPoint.x, lookPoint.y, 0f)) - transform.position;

        //Raycast to check for enemy in front
        Vector2 rayStart = new Vector2(transform.position.x + GetComponent<BoxCollider2D>().bounds.extents.x + 0.1f, transform.position.y);
        RaycastHit2D objectCheck = Physics2D.Raycast(rayStart, transform.right, checkDistance);
        Debug.DrawRay(rayStart, transform.right, Color.yellow, 2f);
        if (objectCheck.collider != null)
        {
            print(objectCheck.collider.tag);
        }
    }
}
