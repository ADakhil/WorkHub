// Calendar and reminders functionality for Seeker Dashboard
class Calendar {
    constructor(container) {
        this.container = container
        this.date = new Date()
        this.selectedDate = new Date()
        this.reminders = this.loadReminders()

        this.render()
        this.attachEventListeners()
    }

    render() {
        const year = this.date.getFullYear()
        const month = this.date.getMonth()

        const firstDay = new Date(year, month, 1)
        const lastDay = new Date(year, month + 1, 0)

        const daysInMonth = lastDay.getDate()
        const startingDay = firstDay.getDay() // 0 = Sunday

        const monthNames = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        ]

        // Create calendar HTML
        let html = `
            <div class="calendar-header">
                <div class="calendar-title">${monthNames[month]} ${year}</div>
                <div class="calendar-nav">
                    <button class="calendar-nav-btn prev-month"><i class="fas fa-chevron-left"></i></button>
                    <button class="calendar-nav-btn next-month"><i class="fas fa-chevron-right"></i></button>
                </div>
            </div>
            <div class="calendar-grid">
                <div class="calendar-day-header">Sun</div>
                <div class="calendar-day-header">Mon</div>
                <div class="calendar-day-header">Tue</div>
                <div class="calendar-day-header">Wed</div>
                <div class="calendar-day-header">Thu</div>
                <div class="calendar-day-header">Fri</div>
                <div class="calendar-day-header">Sat</div>
        `

        // Previous month days
        const prevMonthDays = startingDay
        const prevMonth = new Date(year, month, 0)
        const prevMonthDaysCount = prevMonth.getDate()

        for (let i = prevMonthDays - 1; i >= 0; i--) {
            const day = prevMonthDaysCount - i
            html += `<div class="calendar-day other-month">${day}</div>`
        }

        // Current month days
        const today = new Date()
        for (let i = 1; i <= daysInMonth; i++) {
            const isToday = i === today.getDate() && month === today.getMonth() && year === today.getFullYear()

            const isSelected =
                i === this.selectedDate.getDate() &&
                month === this.selectedDate.getMonth() &&
                year === this.selectedDate.getFullYear()

            const currentDate = new Date(year, month, i)
            const hasReminder = this.hasReminder(currentDate)

            html += `
                <div class="calendar-day ${isToday ? "today" : ""} ${isSelected ? "selected" : ""} ${hasReminder ? "has-reminder" : ""}" 
                     data-date="${year}-${month + 1}-${i}">
                    ${i}
                </div>
            `
        }

        // Next month days
        const totalCells = 42 // 6 rows of 7 days
        const nextMonthDays = totalCells - (prevMonthDays + daysInMonth)

        for (let i = 1; i <= nextMonthDays; i++) {
            html += `<div class="calendar-day other-month">${i}</div>`
        }

        html += `</div>`

        // Reminder form
        html += `
            <div class="reminder-form ${this.selectedDate ? "active" : ""}">
                <h3>Add Reminder for ${this.selectedDate.toLocaleDateString()}</h3>
                <div class="form-group">
                    <input type="text" id="reminderTitle" class="form-control" placeholder="Reminder title">
                </div>
                <div class="form-group">
                    <textarea id="reminderDescription" class="form-control" placeholder="Description"></textarea>
                </div>
                <button type="button" id="addReminderBtn" class="btn btn-primary">Add Reminder</button>
            </div>
        `

        // Reminders list
        html += `
            <div class="reminder-list">
                <h3>Upcoming Reminders</h3>
                <div id="reminderItems">
                    ${this.renderReminders()}
                </div>
            </div>
        `

        this.container.innerHTML = html
    }

    renderReminders() {
        // Filter to show only upcoming reminders
        const today = new Date()
        today.setHours(0, 0, 0, 0)

        const upcomingReminders = this.reminders.filter((reminder) => {
            const reminderDate = new Date(reminder.date)
            reminderDate.setHours(0, 0, 0, 0)
            return reminderDate >= today
        })

        if (upcomingReminders.length === 0) {
            return "<p>No upcoming reminders</p>"
        }

        // Sort by date
        upcomingReminders.sort((a, b) => new Date(a.date) - new Date(b.date))

        let html = ""
        upcomingReminders.forEach((reminder) => {
            const date = new Date(reminder.date)
            html += `
                <div class="reminder-item" data-id="${reminder.id}">
                    <div>
                        <strong>${reminder.title}</strong>
                        <div>${date.toLocaleDateString()}</div>
                        <div>${reminder.description}</div>
                    </div>
                    <button class="reminder-delete" data-id="${reminder.id}">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            `
        })

        return html
    }

    attachEventListeners() {
        // Previous month
        this.container.querySelector(".prev-month").addEventListener("click", () => {
            this.date.setMonth(this.date.getMonth() - 1)
            this.render()
            this.attachEventListeners()
        })

        // Next month
        this.container.querySelector(".next-month").addEventListener("click", () => {
            this.date.setMonth(this.date.getMonth() + 1)
            this.render()
            this.attachEventListeners()
        })

        // Day selection
        this.container.querySelectorAll(".calendar-day:not(.other-month)").forEach((day) => {
            day.addEventListener("click", () => {
                const dateStr = day.dataset.date
                const [year, month, date] = dateStr.split("-").map(Number)
                this.selectedDate = new Date(year, month - 1, date)

                // Remove selected class from all days
                this.container.querySelectorAll(".calendar-day").forEach((d) => {
                    d.classList.remove("selected")
                })

                // Add selected class to clicked day
                day.classList.add("selected")

                // Show reminder form
                const reminderForm = this.container.querySelector(".reminder-form")
                reminderForm.classList.add("active")
                reminderForm.querySelector("h3").textContent = `Add Reminder for ${this.selectedDate.toLocaleDateString()}`
            })
        })

        // Add reminder
        this.container.querySelector("#addReminderBtn").addEventListener("click", () => {
            const title = this.container.querySelector("#reminderTitle").value.trim()
            const description = this.container.querySelector("#reminderDescription").value.trim()

            if (!title) {
                alert("Please enter a reminder title")
                return
            }

            const reminder = {
                id: Date.now(), // Simple unique ID
                date: this.selectedDate.toISOString(),
                title,
                description,
            }

            this.reminders.push(reminder)
            this.saveReminders()

            // Clear form
            this.container.querySelector("#reminderTitle").value = ""
            this.container.querySelector("#reminderDescription").value = ""

            // Update calendar and reminders list
            this.render()
            this.attachEventListeners()
        })

        // Delete reminder
        this.container.querySelectorAll(".reminder-delete").forEach((btn) => {
            btn.addEventListener("click", (e) => {
                e.stopPropagation()
                const id = Number.parseInt(btn.dataset.id)

                if (confirm("Are you sure you want to delete this reminder?")) {
                    this.reminders = this.reminders.filter((r) => r.id !== id)
                    this.saveReminders()

                    // Update calendar and reminders list
                    this.render()
                    this.attachEventListeners()
                }
            })
        })
    }

    hasReminder(date) {
        const dateStr = date.toISOString().split("T")[0]
        return this.reminders.some((reminder) => {
            const reminderDate = new Date(reminder.date).toISOString().split("T")[0]
            return reminderDate === dateStr
        })
    }

    loadReminders() {
        const reminders = localStorage.getItem("workhub_reminders")
        return reminders ? JSON.parse(reminders) : []
    }

    saveReminders() {
        localStorage.setItem("workhub_reminders", JSON.stringify(this.reminders))

        // Clean up expired reminders
        this.cleanupExpiredReminders()
    }

    cleanupExpiredReminders() {
        const today = new Date()
        today.setHours(0, 0, 0, 0)

        const activeReminders = this.reminders.filter((reminder) => {
            const reminderDate = new Date(reminder.date)
            reminderDate.setHours(0, 0, 0, 0)
            return reminderDate >= today
        })

        this.reminders = activeReminders
        localStorage.setItem("workhub_reminders", JSON.stringify(this.reminders))
    }
}

// Initialize calendar when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
    const calendarContainer = document.getElementById("calendarContainer")
    if (calendarContainer) {
        new Calendar(calendarContainer)
    }
})
