import streamlit as st
import plotly.graph_objects as go
import pandas as pd
import time
import random


st.set_page_config(
    page_title="Smart Home FPGA Controller",
    page_icon="🏠",
    layout="wide"
)


# -----------------------------
# HEADER
# -----------------------------

st.title("🏠 Smart Home Automation Controller on FPGA")

st.markdown(
"""
### FPGA + IoT Smart Automation Dashboard

Real-time monitoring and control interface for:

- Lights
- Fans
- Relays
- Sensors
- Security
- Energy Saving
"""
)


# -----------------------------
# SIDEBAR CONTROL
# -----------------------------

st.sidebar.header("Control Panel")


mode = st.sidebar.selectbox(
    "Operating Mode",
    [
        "MANUAL",
        "SENSOR AUTO",
        "SCHEDULE",
        "ALARM"
    ]
)



security = st.sidebar.toggle(
    "Security Mode"
)


night = st.sidebar.toggle(
    "Night Mode"
)



# -----------------------------
# APPLIANCE CONTROL
# -----------------------------


st.sidebar.subheader("Manual Appliance Control")


light_level = st.sidebar.slider(
    "Light Brightness PWM",
    0,
    255,
    100
)


fan_speed = st.sidebar.slider(
    "Fan Speed PWM",
    0,
    255,
    80
)


relay_state = st.sidebar.toggle(
    "Socket Relay"
)



# -----------------------------
# SENSOR SIMULATION
# -----------------------------


pir = random.choice(
    [
        True,
        False
    ]
)


temperature = random.randint(
    20,
    40
)


ldr = random.randint(
    0,
    100
)



# -----------------------------
# STATUS CARDS
# -----------------------------


col1,col2,col3,col4 = st.columns(4)



with col1:

    st.metric(
        "Motion Sensor",
        "ACTIVE" if pir else "IDLE"
    )


with col2:

    st.metric(
        "Temperature",
        f"{temperature} °C"
    )


with col3:

    st.metric(
        "Light Level",
        f"{ldr}%"
    )


with col4:

    st.metric(
        "Security",
        "ARMED" if security else "OFF"
    )



st.divider()



# -----------------------------
# APPLIANCE STATUS
# -----------------------------


st.subheader("⚡ Appliance Status")


c1,c2,c3 = st.columns(3)



with c1:

    st.success(
        f"""
        💡 LIGHT

        PWM : {light_level}

        STATUS:
        {"ON" if light_level>0 else "OFF"}
        """
    )



with c2:

    st.info(
        f"""
        🌀 FAN

        SPEED PWM : {fan_speed}

        STATUS:
        {"ON" if fan_speed>0 else "OFF"}
        """
    )



with c3:

    st.warning(
        f"""
        🔌 RELAY

        STATUS:

        {"ON" if relay_state else "OFF"}
        """
    )



# -----------------------------
# PWM GAUGE
# -----------------------------


st.subheader("PWM Monitoring")


fig = go.Figure()



fig.add_trace(
    go.Indicator(
        mode="gauge+number",
        value=light_level,
        title={"text":"Light PWM"},
        gauge={
            "axis":{
                "range":[0,255]
            }
        }
    )
)



fig.update_layout(
    height=300
)


st.plotly_chart(fig,use_container_width=True)



# -----------------------------
# SENSOR GRAPH
# -----------------------------


st.subheader("Sensor History")


data=pd.DataFrame(
{
"Time":range(20),

"Temperature":
[
random.randint(25,40)
for i in range(20)
],

"Light":
[
random.randint(0,100)
for i in range(20)
]

}

)


st.line_chart(
data.set_index("Time")
)



# -----------------------------
# FSM DISPLAY
# -----------------------------


st.subheader("FPGA FSM State")


if security and pir:

    state="ALARM"

elif mode=="MANUAL":

    state="MANUAL CONTROL"

elif pir and ldr<30:

    state="SENSOR AUTOMATION"

else:

    state="IDLE"



st.code(
f"""
CURRENT FPGA STATE

{state}

Priority:

ALARM
   |
MANUAL
   |
SENSOR AUTO
   |
SCHEDULE

"""
)



# -----------------------------
# UART / ESP32 VIEW
# -----------------------------


st.subheader("UART - ESP32 MQTT Bridge")


uart = {

"MODE":mode,

"LIGHT_PWM":light_level,

"FAN_PWM":fan_speed,

"RELAY":relay_state,

"ALARM":security

}


st.json(uart)



# -----------------------------
# FOOTER
# -----------------------------


st.success(
"FPGA Controller Connected Successfully"
)