using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Attack : MonoBehaviour
{
    [SerializeField]
    private float speed;
    private Rigidbody2D body;
    private GameObject player;

    [SerializeField]
    private GameObject particles;

    private Vector2 move;
    // Start is called before the first frame update
    void Start()
    {
        body = GetComponent<Rigidbody2D>();
        player = GameObject.Find("Brain");
    }

    // Update is called once per frame
    void Update()
    {
        body.MovePosition(Vector2.MoveTowards(transform.position, player.transform.position, .1f) * speed);
    }
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Player")
        {
            Destroy(gameObject);
            particles.transform.parent = null;
            Instantiate(particles, new Vector2(transform.position.x, transform.position.y), Quaternion.identity);
        }
    }
}
