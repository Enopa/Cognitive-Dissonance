using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Attack : MonoBehaviour
{
    [SerializeField]
    private float speed;
    private Rigidbody2D body;
    private GameObject player;

    private GameObject particles;
    private ParticleSystem.MainModule particleSystem;
    private Color mainColor;

    //For the spinny attack
    private float startAngle;
    private float spinTimer;
    private float timer;
    private float radius = 10;


    // Start is called before the first frame update
    void Start()
    {

    }

    private void OnEnable()
    {
        mainColor = gameObject.GetComponent<SpriteRenderer>().color;
        body = GetComponent<Rigidbody2D>();
        player = GameObject.Find("Brain");

        //Particles and trail will be based automatically on the sprite color
        particles = Resources.Load("Prefabs/ParticleStuff/AttackExplosion") as GameObject;
        particleSystem = particles.GetComponent<ParticleSystem>().main;
        particleSystem.startColor = mainColor;

        gameObject.GetComponent<TrailRenderer>().startColor = mainColor;

        startAngle = Random.Range(0, 6);
    }

    // Update is called once per frame
    void Update()
    {

        //Added a switch statement so that the different attacks can be controlled by a single script
        //Ensures that setSpeed can be used on all attacks whenever spawning them
        switch (gameObject.name)
        {
            case "Attack_Proj(Clone)":
                body.MovePosition(Vector2.MoveTowards(transform.position, player.transform.position, .1f * speed));
                break;
            case "Attack_Sprl(Clone)":
                timer += Time.deltaTime;
                float x = Mathf.Cos(startAngle) * radius;
                float y = Mathf.Sin(startAngle) * radius;

                transform.position = new Vector2(x, y);
                startAngle += 1 * Time.deltaTime * speed;
                if (timer > spinTimer)
                {
                    timer = 0;
                    radius -= 0.01f;
                }
                break;
        }

    }

    public void setSpeed(float spd)
    {
        speed = spd;
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
