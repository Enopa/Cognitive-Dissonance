using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class DamageHandler : MonoBehaviour
{
    private Slider health;
    private GameObject slider;
    private float timer = 0;
    // Start is called before the first frame update
    void Start()
    {
        slider = GameObject.Find("Health");
        health = slider.GetComponent<Slider>();
        slider.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        //Reloads the scene if you die
        if (health.value <= 0)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().name);
        }

        //Ensures the health bar only appears for a brief period of time
        if (slider.activeSelf)
        {
            timer += Time.deltaTime;
        }
        if (timer > 1.5)
        {
            slider.SetActive(false);
        }
    }

    public void OnTriggerEnter2D(Collider2D collision)
    {
        //Depletes the health bar and removes bit of health
        if (collision.tag == "Attack")
        {
            health.value -= 34;
            Destroy(collision.gameObject);
            slider.SetActive(true);
            timer = 0f;
        }
    }
}
