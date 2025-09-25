import { useEffect, useState } from "react";

interface BindBoxProps {
    slot: number;
    image?: string;
}

export const BindBox = ({
    slot,
    image
}: BindBoxProps) => {
    return (
        <div className="relative size-12 rounded-md bg-custom-black/80 grid place-items-center">
            <div className="bg-primary text-white rounded-bl-md rounded-tr-md size-4 grid place-items-center font-semibold text-xs absolute left-2 -bottom-[20px] -translate-x-1/2 -translate-y-5">
                {slot + 1}
            </div>
            {image ? (
                <img
                    src={image}
                    alt=""
                    className="w-12"
                />
            ) : null}
        </div>
    );
};

export const Binds = () => {
    const [binds, setBinds] = useState<BindBoxProps[]>([]);

    useEffect(() => {
        interface MessageData {
            eventName: "nui:binds:update";
            data: BindBoxProps[];
        }

        const onMessage = ({ data }: MessageEvent<MessageData>) => {
            if (data.eventName === "nui:binds:update") {
                setBinds(data.data);
            }
        }

        window.addEventListener("message", onMessage);

        return () => window.removeEventListener("message", onMessage);
    }, []);

    return (
        <div className="flex gap-3 fixed right-4 bottom-2 -translate-y-2">
            {Array.from({ length: 5 }).map((_, index) => (
                <BindBox
                    key={index}
                    slot={index}
                    image={binds[index] && (binds[index].image ? binds[index].image : "")}
                />
            ))}
        </div>
    )
}