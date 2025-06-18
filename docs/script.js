class ARLIZTimeline {
  constructor() {
    this.timelineItems = document.querySelectorAll(".timeline-item")
    this.scrollIndicator = document.getElementById("scrollIndicator")
    this.timeProgress = document.querySelector(".time-progress::after")
    this.particles = []
    this.isScrolling = false
    this.scrollDots = []

    this.init()
  }

  init() {
    this.createParticles()
    this.setupScrollIndicator()
    this.setupIntersectionObserver()
    this.setupScrollProgress()
    this.addEventListeners()
  }

  createParticles() {
    const particlesContainer = document.getElementById("particles")
    const particleCount = 50
    const colors = ["#ffd700", "#ff6b35", "#4682b4", "#9932cc", "#00ced1"]

    for (let i = 0; i < particleCount; i++) {
      const particle = document.createElement("div")
      particle.className = "particle"

      const size = Math.random() * 4 + 2
      const color = colors[Math.floor(Math.random() * colors.length)]
      const opacity = Math.random() * 0.6 + 0.2

      particle.style.cssText = `
                width: ${size}px;
                height: ${size}px;
                background: ${color};
                opacity: ${opacity};
                left: ${Math.random() * 100}%;
                animation-delay: ${Math.random() * 8}s;
                animation-duration: ${Math.random() * 10 + 15}s;
                animation-name: floatParticle;
                animation-iteration-count: infinite;
                animation-timing-function: linear;
            `

      particlesContainer.appendChild(particle)
      this.particles.push(particle)
    }

    // Add particle animation keyframes
    if (!document.querySelector("#particle-styles")) {
      const style = document.createElement("style")
      style.id = "particle-styles"
      style.textContent = `
                @keyframes floatParticle {
                    0% {
                        transform: translateY(100vh) translateX(0) rotate(0deg);
                        opacity: 0;
                    }
                    10% { opacity: 1; }
                    90% { opacity: 1; }
                    100% {
                        transform: translateY(-100px) translateX(${Math.random() * 200 - 100}px) rotate(360deg);
                        opacity: 0;
                    }
                }
            `
      document.head.appendChild(style)
    }
  }

  setupScrollIndicator() {
    // Clear existing dots
    this.scrollIndicator.innerHTML = '<div class="scroll-line"></div>'
    this.scrollDots = []

    // Create scroll dots for each timeline item
    this.timelineItems.forEach((item, index) => {
      const dot = document.createElement("div")
      dot.className = "scroll-dot"
      dot.setAttribute("data-index", index)

      dot.addEventListener("click", (e) => {
        e.preventDefault()
        this.scrollToItem(index)
      })

      this.scrollIndicator.appendChild(dot)
      this.scrollDots.push(dot)
    })
  }

  setupIntersectionObserver() {
    const observerOptions = {
      threshold: 0.5,
      rootMargin: "-20% 0px -20% 0px",
    }

    const observer = new IntersectionObserver((entries) => {
      let mostVisibleEntry = null
      let maxIntersectionRatio = 0

      entries.forEach((entry) => {
        if (entry.isIntersecting && entry.intersectionRatio > maxIntersectionRatio) {
          maxIntersectionRatio = entry.intersectionRatio
          mostVisibleEntry = entry
        }
      })

      if (mostVisibleEntry) {
        const index = Number.parseInt(mostVisibleEntry.target.getAttribute("data-index"))

        mostVisibleEntry.target.classList.add("animate")

        this.updateActiveScrollDot(index)

        this.animateTimelineDot(mostVisibleEntry.target)

        this.updateEraEffects(mostVisibleEntry.target)
      }

      entries.forEach((entry) => {
        if (!entry.isIntersecting) {
          entry.target.classList.remove("animate")
        }
      })
    }, observerOptions)

    this.timelineItems.forEach((item) => {
      observer.observe(item)
    })
  }

  updateActiveScrollDot(activeIndex) {
    this.scrollDots.forEach((dot) => dot.classList.remove("active"))

    if (this.scrollDots[activeIndex]) {
      this.scrollDots[activeIndex].classList.add("active")
    }
  }

  animateTimelineDot(timelineItem) {
    const dot = timelineItem.querySelector(".timeline-dot")
    if (dot) {
      dot.style.transform = "translateX(-50%) scale(1.4)"
      dot.style.boxShadow = "0 0 25px currentColor"

      setTimeout(() => {
        dot.style.transform = "translateX(-50%) scale(1)"
        dot.style.boxShadow = "0 0 15px currentColor"
      }, 600)
    }
  }

  updateEraEffects(timelineItem) {
    const era = timelineItem.getAttribute("data-era")
    const content = timelineItem.querySelector(".timeline-content")

    content.style.boxShadow = `0 20px 60px rgba(0, 0, 0, 0.4), 0 0 30px var(--${era}-color, rgba(255, 215, 0, 0.3))`

    setTimeout(() => {
      content.style.boxShadow = "0 10px 40px rgba(0, 0, 0, 0.3)"
    }, 1000)
  }

  setupScrollProgress() {
    const updateProgress = () => {
      const scrollTop = window.pageYOffset
      const docHeight = document.documentElement.scrollHeight - window.innerHeight
      const scrollPercent = Math.min((scrollTop / docHeight) * 100, 100)

      const progressBar = document.querySelector(".time-progress")
      if (progressBar) {
        progressBar.style.setProperty("--progress", `${scrollPercent}%`)
      }

      const scrollLine = document.querySelector(".scroll-line")
      if (scrollLine) {
        scrollLine.style.setProperty("--scroll-progress", `${scrollPercent}%`)
      }
    }

    const style = document.createElement("style")
    style.textContent = `
            .time-progress::after {
                width: var(--progress, 0%);
            }
            .scroll-line::after {
                height: var(--scroll-progress, 0%);
            }
        `
    document.head.appendChild(style)

    window.addEventListener("scroll", updateProgress)
    updateProgress() // Initial call
  }

  scrollToItem(index) {
    const targetItem = this.timelineItems[index]
    if (targetItem) {
      const targetRect = targetItem.getBoundingClientRect()
      const currentScrollTop = window.pageYOffset

      const targetAbsoluteTop = targetRect.top + currentScrollTop

      const viewportHeight = window.innerHeight
      const targetHeight = targetRect.height
      const offsetTop = targetAbsoluteTop - viewportHeight / 2 + targetHeight / 2

      window.scrollTo({
        top: Math.max(0, offsetTop),
        behavior: "smooth",
      })

      this.updateActiveScrollDot(index)
    }
  }

  addEventListeners() {
    let lastScrollTop = 0
    const navbar = document.querySelector(".navbar")

    window.addEventListener("scroll", () => {
      const scrollTop = window.pageYOffset

      if (scrollTop > lastScrollTop && scrollTop > 100) {

        navbar.style.transform = "translateY(-100%)"
      } else {
        navbar.style.transform = "translateY(0)"
      }

      lastScrollTop = scrollTop
    })

    const arlizLetters = document.querySelectorAll(".arliz-letter")
    arlizLetters.forEach((letter, index) => {
      letter.addEventListener("mouseenter", () => {
        this.createRippleEffect(letter)

        arlizLetters.forEach((otherLetter, otherIndex) => {
          if (otherIndex !== index) {
            otherLetter.style.transform = "scale(0.95)"
            otherLetter.style.opacity = "0.7"
          }
        })
      })

      letter.addEventListener("mouseleave", () => {
        // Reset other letters
        arlizLetters.forEach((otherLetter) => {
          otherLetter.style.transform = ""
          otherLetter.style.opacity = ""
        })
      })
    })

    // Timeline dot click interactions
    this.timelineItems.forEach((item, index) => {
      const dot = item.querySelector(".timeline-dot")
      dot.addEventListener("click", () => {
        this.scrollToItem(index)
      })
    })

    // Keyboard navigation
    document.addEventListener("keydown", (e) => {
      if (e.key === "ArrowDown" || e.key === "ArrowUp") {
        e.preventDefault()
        const currentActive = document.querySelector(".scroll-dot.active")
        if (currentActive) {
          const currentIndex = Number.parseInt(currentActive.getAttribute("data-index"))
          let nextIndex

          if (e.key === "ArrowDown") {
            nextIndex = Math.min(currentIndex + 1, this.timelineItems.length - 1)
          } else {
            nextIndex = Math.max(currentIndex - 1, 0)
          }

          this.scrollToItem(nextIndex)
        } else {
          // If no active dot, start with first item
          this.scrollToItem(0)
        }
      }
    })
  }

  createRippleEffect(element) {
    const ripple = document.createElement("div")
    ripple.style.cssText = `
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 215, 0, 0.3);
            transform: scale(0);
            animation: ripple 0.6s linear;
            pointer-events: none;
            z-index: -1;
        `

    const rect = element.getBoundingClientRect()
    const size = Math.max(rect.width, rect.height)
    ripple.style.width = ripple.style.height = size + "px"
    ripple.style.left = rect.width / 2 - size / 2 + "px"
    ripple.style.top = rect.height / 2 - size / 2 + "px"

    element.appendChild(ripple)

    setTimeout(() => {
      ripple.remove()
    }, 600)

    // Add ripple animation if not exists
    if (!document.querySelector("#ripple-styles")) {
      const style = document.createElement("style")
      style.id = "ripple-styles"
      style.textContent = `
                @keyframes ripple {
                    to {
                        transform: scale(4);
                        opacity: 0;
                    }
                }
            `
      document.head.appendChild(style)
    }
  }
}

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  new ARLIZTimeline()
})

// Add loading animation
window.addEventListener("load", () => {
  document.body.classList.add("loaded")

  // Stagger animation for timeline items
  const timelineItems = document.querySelectorAll(".timeline-item")
  timelineItems.forEach((item, index) => {
    setTimeout(() => {
      item.style.animationDelay = `${index * 0.1}s`
    }, 100)
  })
})
